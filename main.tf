
resource "aws_ecr_repository" "repo" {
  name = "newrepo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "repo-policy" {
  repository = aws_ecr_repository.repo.name

  policy = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Keep image deployed with tag 'v''",
      "selection": {
        "tagStatus": "tagged",
        "tagPrefixList": ["v"],
        "countType": "imageCountMoreThan",
        "countNumber": 1
      },
      "action": {
        "type": "expire"
      }
    },
    {
      "rulePriority": 2,
      "description": "Keep last 2 any images",
      "selection": {
        "tagStatus": "any",
        "countType": "imageCountMoreThan",
        "countNumber": 2
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF

}
# data "aws_caller_identity" "current" {}

# output "account_id" {
#   value = data.aws_caller_identity.current.account_id
# }

# data "aws_ecr_repository" "service" {
#   name = "newrepo"
# }

# output "repository_url" {
#  value = data.aws_ecr_repository.service.repository_url
# }


# added after radha's discussion

data "archive_file" "server_bundle" {
  type        = "zip"
  source_dir  = "${path.root}"
  output_path = "${path.root}"
}


resource "null_resource" "ecr_image" {
  triggers = {
    #timestamp        = timestamp()
    #source_dir       = "${path.root}"
    #output_path      = "${path.module}/${local.serverBundleFileName}"
    #server_env_file  = local_file.server_env.filename
    server_bundle_hash = data.archive_file.server_bundle.output_base64sha256
  }
  # Runs the build.sh script which builds the dockerfile and pushes to ecr
  provisioner "local-exec" {
    command = "sh build.sh ${aws_ecr_repository.repo.repository_url} ${aws_ecr_repository.repo.repository_url}:latest"
    
  }
}


#data.aws_caller_identity.current.account_id
