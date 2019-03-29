=pod
Perl Moose packages to test VSCode colorize
This file is used to to test VSCode Colorization
=cut


#########################################################
# Test:       Moose Language is injected only in source #
#########################################################

# Pattern:    use Moose
package TestMooseInjectSource {   
    use Moose;

    # Assert: comment.line.number-sign.perl
    # use Moose;

    sub test {
        # Assert: string.quoted.double.perl
        my $double_quoted_string = "use Moose;";

        # Assert: string.quoted.single.perl
        my $single_quoted_string = 'use Moose;';

        # Assert: string.quoted.other.q.perl
        my $q_quoted_string = q/use Moose;/;
    }
}

########################################################################
# Test:       Multiple package grammars can be loaded at the same time #
########################################################################

# Pattern:    use Moose
package TestMooseInjectPackages {
    # Assert: meta.moose.perl
    use Moose;

    # Assert: meta.type.constraint.moose.perl
    use Moose::Util::TypeConstraints;

    # Assert: keyword.other.attribute.moose.perl
    has 'attr' => ( is => 'ro', required => 0 );

    # Assert: keyword.control.moose.perl
    subtype 'TestSubType', as 'Str';
}

# Pattern: moose
package TestMooseRoleMoose {
    use Moose::Role;

    # Assert: keyword.other.attribute.moose.perl string.quoted.single.perl
    has 'attribute' => (
        is       => 'ro',
        required =>0
    );

    # Assert: keyword.other.role.moose.perl
    requires 'required_attr';

    # Assert: keyword.other.attribute.moose.perl string.quoted.single.perl
    augment 'base_method1' => sub { };
}
