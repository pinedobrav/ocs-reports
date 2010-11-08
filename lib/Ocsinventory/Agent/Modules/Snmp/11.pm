###
# SNMP: OID:11 SYSTEM:HP
###


package Ocsinventory::Agent::Modules::Snmp::11;

use strict;
no strict 'refs';
use warnings;
use Data::Dumper;

sub snmp_run {
  my ($session,$snmp) = @_;

  my $common = $snmp->{common};
  my $logger=$snmp->{logger};

  my $list_mib=["If_Mib","Host_Resources_Mib", "Printer_Mib"];

  $logger->debug("Launching MIB HP 11");

  foreach my $mib ( @{$list_mib} ) {
     $logger->debug("Sub mib $mib");
     $snmp->snmp_oid_run($mib);
  }


}
1;