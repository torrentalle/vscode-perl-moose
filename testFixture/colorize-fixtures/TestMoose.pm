=pod
Perl Moose packages to test VSCode colorize
This file is used to to test VSCode Colorization
=cut


#########
# Stubs #
#########

sub has {};

package TestMooseBase { 
    use Moose;
    has attribute => (is => 'ro', required => 0 );
    sub base_method1 {};
    sub base_method2 {};
}

package TestMooseRole {
    use Moose::Role ;
    has role_attribute => (is => 'ro', required => 0 )
}


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


###############################################
# Test:       Moose Package scope is detected #
# Repository: moose_packages                  #
###############################################

# Pattern:    use Moose
package TestMoosePackages {
    # Assert: entity.name.class.moose.perl
    use Moose;
}

# Pattern:    use Moose
package TestMoosePackagesNo {
    # Assert: entity.name.class.moose.perl
    use Moose;

    no Moose;
}
# Assert: !meta.moose.perl
has;

###############################################
# Test:       Moose syntax is colorized       #
# Repository: moose                           #
###############################################

# Pattern: -meta_name
package TestMooseMeta {
    # Assert: entity.other.attribute-name.moose.perl
    use Moose -meta_name =>'my_meta';
}

# Pattern: keyword.control.moose.perl
package TestMooseImport {
    use Moose;
    # Assert: keyword.control.import.moose.perl entity.other.attribute-name.moose.perl
    extends 'TestMooseBase';
    # Assert: keyword.control.import.moose.perl entity.other.attribute-name.moose.perl
    with TestMooseRole;
}

# Pattern: keyword.control.moose.perl
package TestMooseHas {
    use Moose;
    with 'TestMooseRole';
    
    # Assert: keyword.other.attribute.moose.perl entity.other.attribute-name.moose.perl
    has attribute => ( 
        auto_deref     => 1,
        clearer        => 'clear_attribute',
        coerce         => 0,
        default        => sub { [] },
        documentation  => 'attribute',
        handles => {
            add_item  => 'push',
            next_item => 'shift',
        },
        is             => 'ro',
        isa            => 'ArrayRef',
        lazy           => 0,
        metaclass      => 'Moose::Meta::Attribute',
        predicate      => 'has_attribute',
        required       => 0,
        traits         => ['Array'],
        trigger        => sub {},
        weak_ref       => 0,

    );

    # Assert: keyword.other.attribute.moose.perl string.quoted.single.perl
    has 'buildin_attribute' => ( 
        is         => 'ro',
        builder    => 'build_attribute',
        does       => 'TestMooseRole',
        lazy_build => 1,
        role_attribute => 'role_attribute',
    );

    sub build_attribute {
        return 1;
    };

}

# Pattern: keyword.control.moose.perl
package TestMooseModifiers {
    use Moose;
    extends 'TestMooseBase';
    sub method {};

    # Assert: keyword.other.attribute.moose.perl entity.name.function.perl
    before method => sub {};

    # Assert: keyword.other.attribute.moose.perl string.quoted.single.perl
    after 'method' => sub {};

    # Assert: keyword.other.attribute.moose.perl string.quoted.double.perl
    around "method" => sub {
        my ($orig, $self) = @_;
         $self->$orig(@_);
    };

    # Assert: keyword.other.attribute.moose.perl string.quoted.single.perl
    augment 'base_method1' => sub { };

    # Assert: keyword.other.attribute.moose.perl string.quoted.single.perl
    override 'base_method2' => sub {};
}

#Pattern: keyword.control.moose.perl
package TestMooseFunctions {
    use Moose;
    extends 'TestMooseBase';

    augment base_method1 => sub {
        my ($self) = @_;

        # Assert: support.function.moose.perl
        my $class  = blessed $self;  

        # Assert: support.function.moose.perl
        confess if $class;

        # Assert: support.function.moose.perl
        my $content  = inner();  

        # Assert: support.function.moose.perl
        my $meta_class = $self->meta();
        
        return $content;
    };

    override base_method2 => sub {
        # Assert: support.function.moose.perl
        return super();
    };
}
