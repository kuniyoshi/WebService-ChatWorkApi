use strict;
use warnings;
package WebService::ChatWorkApi;
use WebService::ChatWorkApi::UserAgent;
use WebService::ChatWorkApi::DataSet;
use Readonly;
use String::CamelCase qw( camelize );
use Mouse;
use Smart::Args;
use Class::Load qw( try_load_class );

# ABSTRACT: A client library for ChatWork API

our $VERSION = "0.00";

Readonly my $DATASET_CLASS = "WebService::ChatWorkApi::DataSet";

has ua => ( is => "rw", isa => "WebService::ChatWorkApi::UserAgent" );

sub new {
    args my $class,
         my $api_token,
         my $base_url => { optional => 1 };

    my $self = bless {
        ua => WebService::ChatWorkApi::UserAgent->new(
            api_token => $api_token,
            ( defined $base_url ? ( base_url  => $base_url ) : ( ) ),
        ),
    }, $class;

    return $self;
}

sub ds {
    my $self = shift;
    my $name = shift;
    my $class_name = join q{::}, $DATASET_CLASS, camelize( $name );
    try_load_class( $class_name )
        or die "Could not load $class_name";
    return $class_name->new(
        dh => $self->ua,
        @_,
    );
}

1;
