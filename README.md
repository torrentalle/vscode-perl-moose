# Perl Moose Extension for VS Code

[![Build Status](https://travis-ci.com/torrentalle/vscode-perl-moose.svg?branch=master)](https://travis-ci.com/torrentalle/vscode-perl-moose)

[Perl Moose](https://metacpan.org/pod/Moose) syntax highlight support for Visual Studio Code  

![Syntax Highlight](images/grammar.png)

## Features

This extensions includes support for **Moose** and their minimalist variants (**Mouse** and **Moo**).
Currently includes Syntax Highlight for following classes:

* Moose
* Moose::Deprecated
* Moose::Exporter
* Moose::Object
* Moose::Role
* Moose::Util
* Moose::Util::TypeConstraints
* Test::Moose

## Release Notes

See [CHANGELOG.md](CHANGELOG.md) to see latest changes

## Contributing

The grammar sources is written in YAML in [src/syntaxes/](src/syntaxes/) folder and converted
to textmate JSON format in build phase.

### Building

To generate the main grammar:

```bash
npm install
npm run build
```

### Testing

To run the grammar tests:

```bash
npm run test
```

The test cases are stored as markdown files under `testFixture/colorize-fixtures`. Grammar test results are stored under `testFixture/colorize-results`, which are automatically generated from the fixtures.

To test the grammar in VS Code, select the `Extension Tests` configuration in the VS Code debugger and run.

## References

* [Moose::Cookbook::Snack::Keywords](https://metacpan.org/pod/distribution/Moose/lib/Moose/Cookbook/Snack/Keywords.pod) - Restricted "keywords" in Moose

## License

This extension is distributed under [MIT](LICENSE.md) license.
