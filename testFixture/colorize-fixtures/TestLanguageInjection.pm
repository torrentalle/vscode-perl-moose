=pod
Perl Moose packages to test VSCode colorize
This file is used to to test VSCode Colorization
=cut


#########################################################
# Test:       Moose Language is injected only in source #
#########################################################

# Pattern:    use Moose
package TestMooseInject {   
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

