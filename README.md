# troubleshooting-in-kubernetes

Demonstrate various ways to troubleshoot (detect, diagnose, and resolve) problems in Kubernetes

![Final Environment](https://user-images.githubusercontent.com/3911650/42845131-3c81c658-89d2-11e8-8f72-1eb34cfc98af.png)

## Getting Started

Deploy the CloudFormation `infrastructure/cloudformation.json` template. The template creates a user with the following credentials and minimal required permisisons to complete the Lab:

- Username: _student_
- Password: _password_

## Instructions

1. Connect to the bastion host with SSH agent forwarding

1. Enter the following to enable `kubectl` completions:

    ```sh
    echo "source <(kubectl completion bash)" >> ~/.bashrc
    source ~/.bashrc
    ```

1. Attempt to list the nodes in the cluster:

    ```sh
    kubectl get nodes
    ```

1. Copy the kubeconfig from the master node to fix kubectl, entering yes when prompted about the host's authenticity:

    ```sh
    mkdir .kube  # create the .kube directory
    master_ip=$(aws ec2 describe-instances --region us-west-2 \
      --filters "Name=tag:Name,Values=k8s-master" \
      --query "Reservations[*].Instances[*].PrivateIpAddress" \
      --output text)  # get the master's IP address using the AWS CLI
    scp -o "ForwardAgent yes" $master_ip:.kube/config .kube/config  # secure copy (scp) the kubeconfig file
    ```

1. Successfully list the nodes in the cluster:

    ```sh
    kubectl get nodes
    ```

## Cleaning Up

Delete the CloudFormation stack to remove all the resources used in the Lab.