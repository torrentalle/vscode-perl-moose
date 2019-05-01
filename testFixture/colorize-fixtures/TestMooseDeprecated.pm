=pod
Perl Moose packages to test VSCode colorize
This file is used to to test VSCode Colorization
=cut


###############################################
# Test:       Moose Package scope is detected #
# Repository: moose_packages                  #
###############################################


# Pattern: meta.moose.deprecated.perl
package TestMooseDeprecated {
    use Moose;
    # Assert: entity.name.type.class.perl
    use Moose::Deprecated;
}

# Pattern: meta.moose.deprecated.perl
package TestMooseDeprecatedApiVersion {
    use Moose;
    # Assert: entity.name.type.class.perl constant.language.type.modifier.moose.perl
    use Moose::Deprecated -api-version => 1;
}
