# Contributing to Neural Trace

Thank you for your interest in contributing to Neural Trace. Neural Trace is a Bash-based command-line tool that turns local system information into beginner-friendly security insights and guided recommendations.

## Ways to contribute

Contributions may include:

- Reporting bugs
- Improving documentation
- Proposing new commands or security checks
- Improving compatibility across Linux distributions
- Testing existing behavior on different systems

## Before you start

- Search the existing issues to see whether the change is already being discussed.
- For a substantial change, open an issue or comment on an existing one before beginning implementation.
- Keep each contribution focused on one logically related change.
- When reporting or testing system behavior, remove API keys, usernames, hostnames, IP addresses, system reports, and other sensitive information.

## Development setup

Clone the repository, make the script executable, and start it:

```bash
git clone https://github.com/brittneyleighb/neural-trace.git
cd neural-trace
chmod +x neural-trace.sh
./neural-trace.sh
```

See the [README](README.md#setup--run) for the currently documented dependencies and setup instructions.

## Making a change

1. Fork the repository.
2. Create a branch with a short, descriptive name.
3. Make one focused change.
4. Test the affected commands locally.
5. Review your diff for credentials and sensitive system information.
6. Commit the change with a concise description.
7. Open a pull request explaining what changed, why it changed, and how it was tested.

## Testing

Neural Trace does not currently include an automated test suite, so contributions should be verified manually.

At minimum, check that:

- The script starts without an unexpected error.
- `help` displays the available commands.
- Commands affected by the change behave as expected.
- System-changing actions still require explicit user confirmation.
- Error messages remain clear and useful to beginners.
- No credentials or sensitive machine data appear in the change.
- The pull request identifies the Linux distribution and version used for testing.
- Optional AI functionality is tested when the change affects it, without committing an API key.

## Bash guidelines

- Preserve the existing Bash implementation unless a broader change has been discussed first.
- Quote variables where appropriate.
- Check that required external commands exist before using them.
- Avoid unguarded distribution-specific package-management or system-administration commands.
- Keep prompts, messages, and recommendations understandable to beginners.
- Do not introduce system-changing behavior without explicit confirmation from the user.

## Linux distribution compatibility

The project is currently documented as tested on Kali Linux and expected to work on Debian-based systems. Do not describe another distribution as supported until the relevant behavior has been tested there.

Compatibility contributions should:

- Identify the distribution and version tested.
- Account explicitly for differences in package managers, firewall tools, and command availability.
- Avoid assuming that `apt` or `ufw` is present.
- Preserve the existing confirmation requirement for system changes.
- Document any remaining limitations.

The current script directly invokes `apt` and `ufw`, so adding Red Hat-based system support requires implementation and testing in addition to documentation changes.

## Pull request checklist

- [ ] My change has one focused purpose.
- [ ] I tested the affected commands locally.
- [ ] I listed the distribution and version used for testing.
- [ ] I did not include credentials or sensitive system information.
- [ ] System-changing actions still require confirmation.
- [ ] I updated the documentation when behavior changed.

## Reporting bugs

Please open an issue and include:

- Linux distribution and version
- Bash version
- The Neural Trace command involved
- Expected behavior
- Actual behavior
- Sanitized error output
- Steps needed to reproduce the problem

Before posting, remove credentials, API keys, usernames, hostnames, IP addresses, and other sensitive machine data.

## License

By contributing, you agree that your contribution will be licensed under the repository's [MIT License](LICENSE).
