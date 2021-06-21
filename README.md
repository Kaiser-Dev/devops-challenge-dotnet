# DevOps Challenge (.NET)

Dotnet Core API-Layer Application

## Repository Structure

    .
    ├── ci            # Azure Pipeline Continuous Integration files (DevOps owned)
    ├── src           # Source files (Developer owned)
    ├── test          # Unit and Integration tests (Developer owned)
    ├── dockerfile    # Container definition for building, testing and deployment (DevOps owned)
    ├── LICENSE
    └── README.md

## Contributing

To build and run the application locally you will need:
* .NET 5 
* SQL Server Local DB

On a Mac or Linux device, you can update the connection string (in `appsettings.Development.json` and `DatabaseContextDesignTimeFactory.cs`) and use Docker to launch SQL Server Developer Edition.

It is highly recommended that test builds are made in containers, with the supplied Dockerfile. In this case, you will only need Docker to be installed and capable of running Windows containers. This will be the method Azure Pipelines will use to build your code.

Contributions are via pull requests. Please follow the guidelines for a quick review.

### Creating a fork

1. Create a fork of the main repository via the [Github website](https://github.com/Kaiser-Dev/devops-challenge-dotnet). The fork should be owned by your account.
1. If you haven't already got a clone of the source on your machine, clone the repo
   * ```git clone git@github.com:Kaiser-Dev/devops-challenge-dotnet.git devops-challenge-dotnet```
1. Disable push to origin (for safety!). This will prevent you from accidentally pushing your changes to the main branch
   * ```git remote set-url --push origin no_push```
1. Add a remote to your fork. This will allow you to submit pull requests later on (in this example, the remote is called 'personal'
   * ```git remote add personal git@github.com:<YOUR_GITHUB_USER>/devops-challenge-dotnet.git```

### Before raising a pull request

1. Ensure the coding guidelines have been followed
1. Add sufficient tests for any change that can be tested using unit or integration tests
1. Commit message summary line references the user story or defect where applicable (e.g. DE123)
   * These should also be present in the pull request title

### Raising a pull request
1. Create a new branch, ideally branched from the 'latest' main (or the 'latest' for a branch you're working on)
2. Make the changes in the branch
   * ```git checkout -B my-changes origin/master --no-track```
2. Push your changes to your fork
   * ```git push personal my-changes```
3. Raise a pull request on here
4. Wait for Azure Pipelines to verify your change (triggers from webhook)
5. Receive a Pull Request review from a team member, as well as the CODEOWNER if applicable.

## Deployment

To Provision an environment for deployment, you will first need the Azure CLI:
https://docs.microsoft.com/en-us/cli/azure/get-started-with-azure-cli

Azure Pipelines are currently set up to work with the named resources created here:

```powershell
# Create a resource group
az group create --name sales-api-rg --location australiasoutheast

# Create a container registry
az acr create --resource-group sales-api-rg --name salesApiContainerReg --sku Basic

# Create a Kubernetes cluster
az aks create `
    --resource-group sales-api-rg `
    --name sales-api-aks `
    --node-count 1 `
    --enable-addons monitoring `
    --generate-ssh-keys
```

When finished, for cost-saving, all provisioned resources can be deleted:

```powershell
# Delete resource group
az group delete --name sales-api-rg
```

## To Do

* Translate static provisioning script to ARM template
* Support parameterised builds to allow for multiple environments
* Collect Unit Test execution results and publish to GitHub, for better visibility on passing/failing tests
