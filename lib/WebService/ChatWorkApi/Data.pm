use strict;
use warnings;
package WebService::ChatWorkApi::Data;
use Mouse;

has ds => ( is => "rw", isa => "WebService::ChatWorkApi::DataSet" );

1;
