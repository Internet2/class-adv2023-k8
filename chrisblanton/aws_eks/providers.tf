provider "aws" {
    shared_config_files = [ "/workspaces/research_devops/secrets/aws-config" ]
    shared_credentials_files = [ "/workspaces/research_devops/secrets/aws-cred" ]
    profile = "default"
}



