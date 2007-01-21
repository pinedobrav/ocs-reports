package Ocsinventory::Agent::Backend::OS::AIX::Memory;
use strict;
sub check { `which lsvpd`; ($? >> 8)?0:1 }

sub run {
  my $params = shift;
  my $inventory = $params->{inventory};

  my $capacity;
  my $description;
  my $numslots;
  my $speed;
  my $type;
  my $n;
  my $flag=0;
  #lsvpd
  my @lsvpd = `lsvpd`;
  # Remove * (star) at the beginning of lines
  s/^\*// for (@lsvpd);
  for(@lsvpd){
    if(/^DS (.+MS.*)/){
      $flag=1; (defined($n))?($n++):($n=0);
      $description = $1;
    }
    if((/^SZ (.+)/) && ($flag)) {$capacity = $1;}
	if((/^PN (.+)/) && ($flag)) {$type = $1;}
	# localisation slot dans type
	if((/^YL (.+)/) && ($flag)) {$numslots = $1;}
	# On rencontre un champ FC alors c'est la fin pour ce device
	if((/^FC .+/) && ($flag)) {$flag=0}; 
	$inventory->addMemories({
		CAPACITY => $capacity,	
	  	DESCRIPTION => $description,
	  	NUMSLOTS => $numslots,
	  	SPEED => $speed,
	  	TYPE => $type,
	})
  }
}

1;
