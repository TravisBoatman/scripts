# Find and delete stale branches from a git repo.

import subprocess
import argparse
from datetime import datetime, timedelta, timezone

def run_git_command(git_dir, *args) -> str:
    """
    Runs a Git command in the specified directory and returns the output.

    Args:
        git_dir (str): Path to the Git directory.
        *args: Additional arguments for the Git command.

    Returns:
        str: Output of the Git command.

    Raises:
        Exception: If the Git command fails.
    """
    result = subprocess.run(['git', '-C', git_dir] + list(args), stdout=subprocess.PIPE, text=True)
    if result.returncode != 0:
        raise Exception(f"Git command failed: {result.stderr}")
    return result.stdout.strip()

def get_branches(git_dir) -> list[str]:
    """
    Retrieves a list of remote branches from the Git repository.

    Args:
        git_dir (str): Path to the Git directory.

    Returns:
        list[str]: List of remote branch names.
    """
    output = run_git_command(git_dir, 'branch', '-r')
    branches = output.split('\n')

    # For each branch, any additional information (such as tracking information) is removed by splitting at ' -> ' and taking the first part.
    branches = [b.split(' -> ')[0].strip() for b in branches if ' -> ' not in b]
    return branches

def get_last_modified_date(branch, git_dir) -> datetime:
    """
    Retrieves the last modified date of a specific branch.

    Args:
        branch (str): Name of the branch.
        git_dir (str): Path to the Git directory.

    Returns:
        datetime or None: Last modified date of the branch (or None if not found).
    """
    output = run_git_command(git_dir, 'log', branch, '-1', '--format=%ci')
    if output:
        return datetime.strptime(output, "%Y-%m-%d %H:%M:%S %z")
    else:
        return None

def is_merged(branch, git_dir, target_branch) -> bool:
    """
    Checks if a branch has been merged into the specified target branch.

    Args:
        branch (str): Name of the branch to check.
        git_dir (str): Path to the Git directory.
        target_branch (str): Name of the target branch (e.g., 'main' or 'master').

    Returns:
        bool: True if the branch is merged, False otherwise.
    """
    try:
        run_git_command(git_dir, 'merge-base', '--is-ancestor', branch, target_branch)
        return True
    except Exception:
        return False

def find_inactive_and_merged_branches(git_dir, months, target_branch) -> list[str]:
    """
    Finds branches that are both inactive and merged into the specified target branch.

    Args:
        git_dir (str): Path to the Git directory.
        months (int): Number of months to check for inactivity.
        target_branch (str): Name of the target branch (e.g., 'main' or 'master').

    Returns:
        list[str]: List of inactive and merged branch names.
    """
    branches = get_branches(git_dir)
    inactive_merged_branches = []
    cutoff_date = datetime.now(timezone.utc) - timedelta(days=30 * months)
    for branch in branches:
        last_modified_date = get_last_modified_date(branch, git_dir)
        if last_modified_date and last_modified_date < cutoff_date:
            if is_merged(branch, git_dir, target_branch):
                inactive_merged_branches.append(branch)
    return inactive_merged_branches

def delete_local_and_remote_branch(git_dir, branch):
    normalized_branch = branch.replace('origin/', '')

    try:
        print(f"Attempting to delete local branch {normalized_branch}.")
        run_git_command(git_dir, 'branch', '-d', normalized_branch)
    except Exception as e:
        pass

    try:
        print(f"Attempting to delete remote tracking branch {normalized_branch}.")
        run_git_command(git_dir, 'branch', '-d', '-r', branch)
    except Exception as e:
        pass

    try:
        run_git_command(git_dir, 'push', 'origin', '--delete', normalized_branch)
        print(f"Deleted branch {normalized_branch} from remote 'origin'.")
    except Exception as e:
        print(f"Branch {normalized_branch} could not be deleted from remote 'origin': {e}")
    
    print("\n")

def main():
    parser = argparse.ArgumentParser(description="Analyze Git branches and find ones not modified in specified months.")
    parser.add_argument('git_dir', type=str, help="Path to the Git directory.")
    parser.add_argument('--months', type=int, default=6, help="Number of months to check for inactivity. Default is 5 months.")
    parser.add_argument('--master_branch', type=bool, default=False, help="Use master branch instead of main branch. Default is False.")
    args = parser.parse_args()

    target_branch = 'master' if args.master_branch else 'main'
    inactive_merged_branches = find_inactive_and_merged_branches(args.git_dir, args.months, target_branch)

    if inactive_merged_branches:
        print(f"Branches not modified in the last {args.months} months and merged into {target_branch}:")
        for branch in inactive_merged_branches:
            print(branch)
        user_input = input("\nDo you want to delete all the above branches? [y/n]: ").lower()
        if user_input == 'y':
            for branch in inactive_merged_branches:
                delete_local_and_remote_branch(args.git_dir, branch)
        else:
            print("No branches were deleted.")

if __name__ == "__main__":
    main()