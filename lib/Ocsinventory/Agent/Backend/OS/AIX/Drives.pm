package Ocsinventory::Agent::Backend::OS::AIX::Drives;

use strict;
sub check {`which df`; ($? >> 8)?0:1}
	
sub run {
  my $params = shift;
  my $inventory = $params->{inventory};
  
  my $free;
  my $filesystem;
  my $total;
  my $type;
  my $volumn;
  
  my @values;
  my $i=0;
  my @fs;
  my @fstype;
  #Looking for mount points and disk space
  # Aix option -kP 
  for(`df -kP`){
    if (/^Filesystem\s*1024-blocks.*/){next};
    if(/^(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\n/){	 
	  $type = $1;
	  @fs=`lsfs -c $1`;
	  @fstype = split /:/,$fs[1];     
	  $filesystem = $fstype[2];
	  $total = sprintf("%i",($2/1024));	
	  $free = sprintf("%i",($4/1024));
	  $volumn = $6;
	  $i++;
	}
	$inventory->addDrives({
 	  FREE => $free,
      FILESYSTEM => $filesystem,
      TOTAL => $total,
      TYPE => $type,
      VOLUMN => $volumn
    })
	
  }
}

1;
