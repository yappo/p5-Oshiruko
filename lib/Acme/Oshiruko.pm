package Acme::Oshiruko;

use strict;
use warnings;

use List::Util qw/reduce/;

use Carp qw/croak/;

our $VERSION = '0.01';

my $map = +{
    lived__r => +{
        nsb => {
            '24f' => {
                kanri => 0,
            },
            '25f' => {
                suntory => 0,
                cocacola => 0,
            },
            '26f' => 0,
        },
        tk => {
            ope => 1,
        },
    },
};

sub new {
    my $this = shift;
    return bless {here => shift}, $this;
}

sub here { (shift)->{here}; }

sub where_to_go {
    my $self = shift;
    return [] unless $map->{$self->here};
    explore($self->here, $map->{$self->here});
};

# livedoor

sub explore {
    my ($node, $val) = @_;
    if (ref $val) {
        return map {explore($node . '/' . $_, $val->{$_})} keys(%$val);
    }
    else {
        if ($val) {
            return $node;
        }
        return ();
    }
}

1;
