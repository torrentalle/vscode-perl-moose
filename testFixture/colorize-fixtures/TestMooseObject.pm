=pod
Perl Moose Object packages to test VSCode colorize
This file is used to to test VSCode Colorization
=cut    


###############################################
# Test:       Moose Object #
# Repository: moose_packages                  #
###############################################

# Pattern:    use Moose
package TestMooseObjectPackage {
    # Assert: entity.name.class.moose.perl
    use Moose;
}

# Assert: support.function.moose.perl
my $object = TestMooseObjectPackage->new();

# Assert: support.function.moose.perl
$object->BUILDARGS({});

# Assert: support.function.moose.perl
$object->isa('TestMooseObjectPackage');

# Assert: support.function.moose.perl
$object->does('TestMooseObjectPackage');

# Assert: support.function.moose.perl
$object->DOES('TestMooseObjectPackage');

# Assert: support.function.moose.perl
$object->dump();

# Assert: support.function.moose.perl
$object->DESTROY();

