#!/usr/bin/perl -w
 
use Tk;
use Tk::Photo;
use File::Find;
use File::Copy;
use File::Path qw(make_path remove_tree);
use File::Copy::Recursive qw(dircopy);
use Switch;

sub start;
sub show;
sub copy_f_d;
sub copy_restore;
sub history;
sub erase;
 
my $logname = $ENV{USER};
my $main = MainWindow -> new;
$main -> geometry("500x400");
$main -> maxsize(500,600);
$main -> minsize(400,400);
$main -> title("REPOSITORY");
#my $image = $main->Photo(-file=>"home/$logname/Desktop/logic.gif");
#$main->iconimage($image);


my $h_frame = $main -> Frame(-background => "orange", -borderwidth => 2) -> pack(-side => 'top',-expand => 1, -fill => "both");
my $m_frame = $main -> Frame(-background => "blue", -borderwidth => 2) -> pack(-side => 'top',-expand => 1,-fill => "both" );
my $l_frame = $main -> Frame(-background => "orange", -borderwidth => 2) -> pack(-side => 'top',-expand => 1, -fill => "both");
$h_frame -> Label(-text => "Welcome To Repository Program", -background => "orange")->pack(-side => "top", -anchor => "center", -expand => 1);
$h_frame -> Label(-text => "Enter the Path: ", -background => "orange")->pack(-side => "top", -anchor => "center", -expand => 1);
my $enter = $h_frame -> Entry(-background => "white", -foreground => "black", -borderwidth => 5, -relief => "ridge") -> pack(-side => "top", -ipady => 10, -expand => 1);
my $show_button = $m_frame->Button(-text => "Show", -command => \&show) -> pack(-side => "left", -anchor => "center", -expand => 1);
my $copy_button = $m_frame->Button(-text => "Copy", -command => \&copy_f_d) -> pack(-side => "left", -anchor => "center",-expand => 1 );
my $copy_restore_button = $m_frame->Button(-text => "Copy_Restore", -command => \&copy_restore) -> pack(-side => "left", -anchor => "center", -expand => 1);
my $history_button = $m_frame->Button(-text => "History", -command => \&history) -> pack(-side => "left", -anchor => "center", -expand => 1);
my $delete_button = $m_frame->Button(-text => "Erase", -command => \&erease) -> pack(-side => "left", -anchor => "center",-expand => 1 );
$l_frame -> Label(-text => "Result: ", -background => "orange")->pack(-side => "top", -anchor => "center", -expand => 1);
my $scroll = $l_frame -> Scrollbar();
my $result = $l_frame -> Text(-yscrollcommand => ['set' => $scroll],-background => "white", -foreground => "black", -borderwidth => 5, -width=>40, -height=>50, -relief => "ridge");
$scroll->configure(-command => ['yview' => $result]);
$scroll->pack(-side => 'right', -fill => 'y');
$result -> pack(-side => "top", -anchor => "center",-fill => "both", -expand => 1 );

&start();
MainLoop;

sub start
{
	$enter -> insert("end", "/home/RePoZyToRiUm/");
	if(!chdir "/home")
	{
		$text = "STH IS WRONG! Try again\n";
		$result -> insert("end", $text);
		die "Directory can not be change to /home: $!";
	}
	else
	{
		$text = "SUCCESS YOU ARE AT HOME DIR\n";
		$result -> insert("end", $text);
		
		if(!(-e "/home/RePoZyToRiUm"))
		{
			if(!mkdir "RePoZyToRiUm", 0000 )
				{
					$text = "STH IS WRONG! Try again";
					$result -> insert("end", $text);
					die "mkdir does not work: $!";
				}
			else
				{
					$text = "Your dir REPOZYTORIUM is built\n";
					$result -> insert("end", $text);
					
				}
		}
		else
		{
			$text = "Your dir REPOZYTORIUM has been already built\n";
			$result -> insert("end", $text);
		}
	}
}


sub show
{
	$result->delete("0.0", "end");
	my $entry_path = $enter -> get();
	my $dir = $entry_path;
	my $fil = $entry_path;
	if(-e -d $dir)
	{
		chmod 0700, "/home/RePoZyToRiUm";
		if(!opendir DIRECTORY, $dir)
		{
			$text = "STH IS WRONG! Try again";
			$result -> insert("end", $text);
			die "Jest jakis probelm z twoim plikiem: $!";	
		}
		$result -> insert("end", "FILES IN $dir:\n");
	
		foreach $file(readdir DIRECTORY)
		{
			$result -> insert("end", "$file \n");
		}
		chmod 0000, "/home/RePoZyToRiUm";
		closedir DIRECTORY;
	}
	elsif(-e -f $fil)
	{
		
		if(!open(Files, $fil))
		{
			$text = "STH IS WRONG! Try again";
			$result -> insert("end", $text);
			die "Jest jakis probelm z twoim plikiem: $!";	
		}
		chmod 0700, "/home/RePoZyToRiUm";
		while($lines = <Files>)
		{
			$result -> insert("end", $lines);
		}
		chmod 0000, "/home/RePoZyToRiUm";
		close Files;
	}
	else
	{
		$text = "STH IS WRONG! Try again";
		$result -> insert("end", $text);
	}
}
sub copy_f_d
{
	$result ->delete("0.0", "end");
	$entry_path = $enter -> get();
	$val = 0;
	
	if(-e -f $entry_path)
	{
		$fil = $entry_path;
		$val = 1;	
	}
	elsif(-e -d $entry_path)
	{
		$dir = $entry_path;
		$val = 2;
	}
	else
	{
		$text = "It does not exist\n";
		$result -> insert("end", $text);
	}
	
	chmod 0700, "/home/RePoZyToRiUm";
	switch($val)
	{
		case 1
		{
			
			if(!chdir "/home/RePoZyToRiUm")
			{
				$text = "STH IS WRONG! Try again\n";
				$result -> insert("end", $text);
				die "Directory can not be change to /home/RePoZyToRiUm: $!";
			}
			else
			{
					
				$text = "SUCCESS YOU ARE AT HOME RePoZyToRiUm DIR\n";
				$result -> insert("end", $text);
				@list_1 = split /\//, $fil;
				($elements_1) = @list_1 - 1;
				@list_2 = split /\./, $list_1[$elements_1];
				($elements_2) = @list_2 - 2;
				$counter = 0;
				$new_path = "/home/RePoZyToRiUm/".$list_1[$elements_1];
					
				for(;;)
				{
				
					if(!(-e $new_path))
					{
						if(copy("$fil",$new_path))
						{
							$text = "You copied $fil\n";
							$result -> insert("end", $text);
							
							unless(open LOG, ">>" , "/home/RePoZyToRiUm/config_file.txt")
							{
								die "CAN NOT OPEN CONFIG_FILE $!";
							}
							else
							{
								printf(LOG "$fil - original\n");
								printf(LOG "$new_path - copy\n");
								close LOG;
							}
	
						}
						else
						{
							$text = "COPY FAILED\n";
							$result -> insert("end", $text);
							die "COPY FAILED: $!";
						}
						last;
					}
					$counter = $counter + 1;
					$path_element = "(COPY"  . $counter . ")";
					$new_path = "/home/RePoZyToRiUm/" . $list_2[$elements_2] . $path_element . "." . $list_2 [ $elements_2 + 1];
				}
			}
		}
		
		case 2
		{
			if(opendir DIR_COPY, $dir)
			{
				@list = split /\//, $dir;
				($elements) = @list - 1;
				$old_dir = $list[$elements];
				$new_dir = $old_dir;
				$new_path = "/home/RePoZyToRiUm/".$list[$elements];
				$counter = 0;			
				if(!chdir "/home/RePoZyToRiUm")
				{
					$text = "STH IS WRONG! Try again\n";
					$result -> insert("end", $text);
					die "Directory can not be change to /home/RePoZyToRiUm: $!";
				}
				else
				{
					$text = "SUCCESS YOU ARE AT HOME RePoZyToRiUm DIR\n";
					$result -> insert("end", $text);
					for(;;)
					{
						if(!(-e $new_path))
						{
							if(!(mkdir $new_dir, 0777))
							{
								$text = "STH IS WRONG! Try again";
								$result -> insert("end", $text);
								die "mkdir does not work: $!";
							}
							else
							{
								$text = "$new_path created\n";
								$result -> insert("end", $text);
								
								unless(open LOG, ">>" , "/home/RePoZyToRiUm/config_file.txt")
								{
									die "CAN NOT OPEN CONFIG_FILE $!";
								}
								else
								{
									printf(LOG "$dir - original\n");
									printf(LOG "$new_path - copy\n");
									close LOG;
								}
							}
							last;
						}
						
						$counter += 1;
						$path_element = "(COPY"  . $counter . ")";
						$new_dir = $old_dir . $path_element;
						$new_path = "/home/RePoZyToRiUm/" . $new_dir;			
					}
				}
				my $counter_1 = 0;
				foreach(readdir DIR_COPY)
				{
					$old_path = "$dir/$_";
					$new_path_1 = $new_path . "/$_ ";
					$counter_1++;
					if(-d $old_path && $counter_1 > 2)
					{	
						
						dircopy($old_path, $new_path_1) or die "MISTAKE: $!";
					}
					elsif(-f $old_path && $counter_1 != 2)
					{
						copy($old_path,$new_path_1);
					}
				}
				
				close DIR_COPY;
			}
			else
			{
				$text = "You did not copy $fil\n";
				$result -> insert("end", $text);
				die "KOPIOWANIE NIEUDANE $!";
			}
		}
	}
	chmod 0000, "/home/RePoZyToRiUm";
}

sub copy_restore
{
	$result -> delete("0.0", "end");
	$entry_path = $enter -> get();
	my @config;
	chmod 0777, "/home/RePoZyToRiUm";
	
	if(!open LOG , "/home/RePoZyToRiUm/config_file.txt")
	{
		die "CAN NOT OPEN CONFIG_FILE $!";
	}
	else
	{
		while(<LOG>)
		{
			chomp;
			push(@config,$_);
		}
		
		for($count = 0; $count < $#config + 1; $count++ )
		{
			if(($entry_path . " - " . "copy") eq $config[$count])
			{
				my @split = split / - /, $config [ $count - 1];
				my @split_1 = split / - /, $config [ $count ];
				if(-f -e $split[0])
				{
					unlink $split[0];
					copy($split_1[0],$split[0]);
					$text = "COPY_RESTORE of $split[0] to $split_1[0]";
					$result -> insert("end", $text);
				}
				elsif(-d -e $split[0])
				{
					remove_tree($split[0]);
					dircopy($split_1[0],$split[0]) or die "MISTAKE $!";
					$text = "COPY_RESTORE of $split[0] to $split_1[0]";
					$result -> insert("end", $text);
				}
				else
				{
					$text = "$split[0] was propably deleted\n";
					$result -> insert("end", $text);
				}
			}
		}
		close LOG;
	}
}

sub history
{
	$result->delete("0.0", "end");
	$entry_path = $enter -> get();
	chmod 0777 , "/home/RePoZyToRiUm";
	my @list;
	if(opendir DIR, "/home/RePoZyToRiUm")
	{
		foreach(readdir DIR)
		{
			push(@list, "/home/RePoZyToRiUm/" . $_ ); 
		}
		
		foreach(@list)
		{
			$exist = 1;
			if($_ eq $entry_path)
			{
				my @info = stat($entry_path);
				my @keys = ("DEVICE NUMBER" ,  "INODE NUMBER" , "FILE MODE" , "NUMBER OF LINKS", "UID", "GID", "RDEV", "SIZE IN BYTES", "LAST ACESS TIME", "LAST MODIFY TIME", "INODE CHANGE","I/O SIZE BLOKS","ACTUAL NUMBER OF SYSTEM-SPECIFIC BLOCKS");
				my %hash;
				$counter = 0;
	
				foreach(@info)
				{
					unless(($counter eq 8) or ($counter eq 9) or ($counter eq 10))
					{
						$hash{$keys[$counter]} = $_ ;
					}
					else
					{	
						my $timestamp = $_;
						my $date = localtime $timestamp;
						$hash{$keys[$counter]} = $date ;
					}
					$counter += 1;
				}
	
	
				foreach(sort(keys %hash))
				{
					$text = $_ . " " . $hash{$_} . "\n";
					$result -> insert("end", $text);
				}
				$exist = 0;
				last;
			}
		}
		
		if($exist)
		{
			$text = "NO SUCH THING\n";
			$result -> insert("end", $text);
		}
	}
	else
	{
		$text = "OPEN FAILED\n";
		$result -> insert("end", $text);
		chmod 0000 , "/home/RePoZyToRiUm";
		die "OPEN FAILED $!";
	}
	chmod 0000 , "/home/RePoZyToRiUm";
	close DIR;
	$enter->delete("0.0", "end");
	$enter -> insert("end", "/home/RePoZyToRiUm");
}

sub erease
{
	my $val = 0;
	$result->delete("0.0", "end");
	$entry_path = $enter -> get();
	my @list;
	
	if(opendir DIR, "/home/RePoZyToRiUm")
	{
		foreach(readdir DIR)
		{
			push(@list, "/home/RePoZyToRiUm/" . $_ ); 
		}
		
		foreach(@list)
		{
			if($_ eq $entry_path && -f $entry_path )
			{
				$val = 1;
				unlink $entry_path;
				$text = "FILE $entry_path EREASED\n";
				$result -> insert("end", $text);
				unless(open LOG , "/home/RePoZyToRiUm/config_file.txt")
				{
					die "CAN NOT OPEN CONFIG_FILE $!";
				}
				else
				{
					my @config_list;
					while(<LOG>)
					{
						chomp;
						unless($_ eq ($entry_path . " - ". "copy"))
						{
							push(@config_list,$_);
						}
						else
						{
							pop @config_list;
						}
					}
					close LOG;
					
					unless(open LOG, ">" , "/home/RePoZyToRiUm/config_file.txt")
					{
						die "CAN NOT OPEN CONFIG_FILE $!";
					}
					else
					{
						foreach(@config_list)
						{
							printf(LOG "$_\n");
						}
						close LOG;
					}
				}
				last;
			}
			elsif($_ eq $entry_path && -d $entry_path)
			{
				$val = 1;		
				remove_tree($entry_path);
				$text = "DIRECTORY $entry_path EREASED\n";
				$result -> insert("end", $text);
				unless(open LOG , "/home/RePoZyToRiUm/config_file.txt")
				{
					die "CAN NOT OPEN CONFIG_FILE $!";
				}
				else
				{
					my @config_list_1;
					while(<LOG>)
					{
						chomp;
						unless($_ eq ($entry_path . " - ". "copy"))
						{
							push(@config_list_1,$_);
						}
						else
						{
							pop @config_list_1;
						}
					}
					close LOG;
					
					unless(open LOG, ">" , "/home/RePoZyToRiUm/config_file.txt")
					{
						die "CAN NOT OPEN CONFIG_FILE $!";
					}
					else
					{
						foreach(@config_list_1)
						{
							printf(LOG "$_\n");
						}
						close LOG;
					}
				}
				last;
			}
		}
		
		if(!($val))
		{
			$text = "NO SUCH THING: $entry_path\n";
			$result -> insert("end", $text);
		}
		
	}
	else
	{
		$text = "OPEN FAILED\n";
		$result -> insert("end", $text);
		chmod 0000 , "/home/RePoZyToRiUm";
		die "OPEN FAILED $!";
	}
	
	close DIR;
	chmod 0000 , "/home/RePoZyToRiUm";
}



