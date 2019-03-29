=pod
Perl Moose packages to test VSCode colorize
This file is used to to test VSCode Colorization
=cut

#########
# Stubs #
#########

sub subtype {};


##########################################################
# Test:       Moose TypeConstraints syntax is colorized  #
# Repository: moose_type_constraint                      #
##########################################################

# Pattern:    use Moose::Util::TypeConstraints
use Mouse::Util::TypeConstraints;

no Mouse::Util::TypeConstraints;

# Pattern:    use Moose::Util::TypeConstraints
use Moose::Util::TypeConstraints;

# Assert: keyword.control.moose.perl
type 'TestType',
  as 'Str',
  where { 1 },
  message { },
  inline_as { '' };

# Assert: keyword.control.moose.perl
subtype 'TestSubType', as 'Str';

# Assert: keyword.control.moose.perl
match_on_type 'TestMatchOnType' => ( Str => sub { $_; } );

# Assert: keyword.control.moose.perl
coerce 'Str',
  from 'Str', via { };

# Assert: keyword.other.type.moose.perl
class_type 'TestClassType';
role_type 'TestRoleType';
maybe_type 'TesteMaybeType';
duck_type([]);
enum 'TestEnum', ['one', 'two'];
union ['Str', 'Str'];

# Assert: support.function.moose.perl
my $type_constraint = find_type_constraint('Str');
register_type_constraint($type_constraint);
Moose::Util::TypeConstraints::normalize_type_constraint_name($type_constraint);
Moose::Util::TypeConstraints::create_named_type_constraint_union('TestNamedUnion','Str|ArrayRef[Int]');
Moose::Util::TypeConstraints::create_parameterized_type_constraint('ArrayRef[Str]');
Moose::Util::TypeConstraints::create_class_type_constraint('TestCreateTypeConstraint');
Moose::Util::TypeConstraints::create_role_type_constraint('TestCreateRoleTypeConstraint');
Moose::Util::TypeConstraints::create_enum_type_constraint('TestCreateEnumTypeConstraint', ['Str', 'Int'] );
Moose::Util::TypeConstraints::create_duck_type_constraint('TestCreateDuckTypeConstraint', ['Str', 'Int'] );
Moose::Util::TypeConstraints::find_or_parse_type_constraint('Str');
Moose::Util::TypeConstraints::find_or_create_isa_type_constraint('Str');
Moose::Util::TypeConstraints::find_or_create_does_type_constraint('Str');
Moose::Util::TypeConstraints::get_type_constraint_registry;
Moose::Util::TypeConstraints::list_all_type_constraints;
Moose::Util::TypeConstraints::list_all_builtin_type_constraints;
Moose::Util::TypeConstraints::export_type_constraints_as_functions;
my @types = Moose::Util::TypeConstraints::get_all_parameterizable_types;
Moose::Util::TypeConstraints::add_parameterizable_type($types[0]);

no Moose::Util::TypeConstraints;

# Assert: !meta.type.constraint.moose.perl
subtype();
