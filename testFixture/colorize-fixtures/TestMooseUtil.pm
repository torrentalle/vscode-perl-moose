=pod
Perl Moose Util packages to test VSCode colorize
This file is used to to test VSCode Colorization
=cut    


###############################################
# Test:       Moose Util syntax               #
# Repository: moose_packages                  #
###############################################

# Pattern:    use Moose
use Moose::Util qw/find_meta does_role search_class_by_role/;
 
my $meta = find_meta($object) || die "No metaclass found";
 
if (does_role($object, $role)) {
  print "The object can do $role!\n";
}
 
my $class = search_class_by_role($object, 'FooRole');
print "Nearest class with 'FooRole' is $class\n";



