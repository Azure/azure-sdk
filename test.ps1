    git diff --exit-code
    if ($LastExitCode -ne 0) {
      echo "##vso[task.setvariable variable=HasChanges]$true"
    }
    else {
      echo "No changes so skipping code push"
      exit
    }


    echo "Checking out and resetting branch branchName"
    git checkout -B Testing
    
    echo "Commiting changes"
    git -c user.name="azure-sdk" -c user.email="azuresdk@microsoft.com" commit -am "Testing"

git push https://github.com/weshaggard/azure-sdk.git -f Testing
echo "LastExitCode = $LastExitCode"