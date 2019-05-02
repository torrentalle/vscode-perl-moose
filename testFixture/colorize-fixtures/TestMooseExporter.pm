=pod
Perl Moose Exporter package to test VSCode colorize
This file is used to to test VSCode Colorization
=cut

package TestMooseExporter;
 
use Moose ();
use Moose::Exporter;
use Some::Random ();
 
Moose::Exporter->setup_import_methods(
    with_meta => [ 'has_rw', 'sugar2' ],
    as_is     => [ 'sugar3', \&Some::Random::thing, 'Some::Random::other_thing' ],
    also      => 'Moose',
);
 
sub has_rw {
    my ( $meta, $name, %options ) = @_;
    $meta->add_attribute(
        $name,
        is => 'rw',
        %options,
    );
}
