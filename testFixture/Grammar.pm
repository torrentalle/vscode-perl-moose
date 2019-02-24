package Point;
use Moose;
 
has 'x' => (isa => 'Int', is => 'rw', required => 1);
has 'y' => (isa => 'Int', is => 'rw', required => 1);
 
sub clear {
    my $self = shift;
    $self->x(0);
    $self->y(0);
}
 
package Point3D;
use Moose;
 
extends 'Point';
 
has 'z' => (isa => 'Int', is => 'rw', required => 1);
 
after 'clear' => sub {
    my $self = shift;
    $self->z(0);
};
