# Modified version of the work: Copyright (C) 2019 Ligero, https://www.complemento.net.br/
# based on the original work of:
# Copyright (C) 2001-2018 OTRS AG, https://otrs.com/# --
# Copyright (C) 2001-2017 LIGERO AG, http://ligero.com/
# --
# This software comes with ABSOLUTELY NO WARRANTY. For details, see
# the enclosed file COPYING for license information (AGPL). If you
# did not receive this file, see http://www.gnu.org/licenses/agpl.txt.
# --

package LIGERO::XML::Simple;

use strict;
use warnings;

eval { require XML::Simple };
if ($@) {
    print "Can't load XML::Simple: $@";
    exit 1;
}

use base 'XML::Simple';

# Override the sort method form XML::Simple
sub sorted_keys {    ## no critic
    my ( $Self, $Name, $Hashref ) = @_;

    # only change sort order for chapter
    if ( $Name eq 'chapter' ) {

        # set the right sort order
        my @Order = qw(title para section);

        my %OrderLookup = map { $_ => 1 } @Order;

        return grep { exists $Hashref->{$_} } @Order,
            grep { !$OrderLookup{$_} } $Self->SUPER::sorted_keys( $Name, $Hashref );
    }

    # only change sort order for section
    if ( $Name eq 'section' ) {

        # set the right sort order
        return ( 'title', 'para', );
    }

    return $Self->SUPER::sorted_keys( $Name, $Hashref );    ## no critic
}

1;
