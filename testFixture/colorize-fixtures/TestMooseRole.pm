=pod
Perl Moose Role package to test VSCode colorize
This file is used to to test VSCode Colorization
=cut

#########
# Stubs #
#########

sub requires {};

###############################################
# Test:       Moose Package scope is detected #
# Repository: moose_packages                  #
###############################################

# Pattern:    use Moose
package TestMooseRole {
    # Assert: entity.name.class.moose.perl
    use Moose::Role;
}

# Pattern:    use Moo
package TestMooRole {
    # Assert: entity.name.class.moose.perl
    use Moo::Role;
}

# Pattern:    use Mouse
package TestMouseRole {
    # Assert: entity.name.class.moose.perl
    use Mouse::Role;
}

# Pattern:    use Moose
package TestMooseRoleNo {
    # Assert: entity.name.class.moose.perl
    use Moose::Role;

    no Moose::Role;
}
# Assert: !meta.role.moose.perl
requires;


###############################################
# Test:       Moose Role syntax is colorized  #
# Repository: moose_role                      #
###############################################

# Pattern: -meta_name
package TestMooseRoleTraits {
    # Assert: entity.other.attribute-name.moose.perl
    use Moose::Role -traits => 'TestMooseRoleTraits';
}

# Pattern: requires/excludes
package TestMooseRoleRequires {
    use Moose::Role;

    # Assert: keyword.other.role.moose.perl
    requires 'required_attr';

    # Assert: keyword.other.role.moose.perl
    excludes 'excluded_attr';
}

# Pattern: moose
package TestMooseRoleMoose {
    use Moose::Role;

    # Assert: keyword.other.attribute.moose.perl string.quoted.single.perl
    has 'attribute' => (
        is       => 'ro',
        required =>0
    );
}
