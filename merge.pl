#!/usr/bin/perl
#use utf8;
 
	opendir (DIR, '.') or die "can't open dir, $!";
	$SubDirNum = 0;
#test
	$SourceDirA_Name='01�´ʱ�/';
	$SourceDirB_Name='02�ϴʱ�/';
	$TargetDir_Name='03���ϴʱ�/';

	print "SourcedirA , $SourceDirA_Name\n";
	print "SourcedirB , $SourceDirB_Name\n";
	print "Targetdir , $TargetDir_Name\n";
	print "======================\n";
	
	opendir (DIR, "$SourceDirA_Name") or die "can't open dir, $!";
	$SubDirNum = 0;
	while ($file = readdir DIR) {
	  $SubDir_Name[$SubDirNum] = $file."/";
	  print "$SubDir_Name[$SubDirNum]\n";
	  $SubDirNum ++;
	}

	mkdir ($TargetDir_Name); #����Ŀ��Ŀ¼
	
	for($a=2;$a<$SubDirNum;$a++){   #ÿ����Ŀ¼�ֱ�����
	  print "====$SubDir_Name[$a]\n";
	  mkdir ($TargetDir_Name.$SubDir_Name[$a]);
	  
	  #�ҳ���ǰĿ¼��TXT�ĵ�
		$dir = "$SourceDirA_Name"."$SubDir_Name[$a]"."*.txt";  
		print "====  �г�  $dir \n";
		@files = glob( $dir );
		
		#���TXT�ĵ�����
		foreach (@files ){    
		   $string = $_ ;
		   $sourcefileA = $string;
		   print $sourcefileA. "\n";
		   
		   $string =~ s/$SourceDirA_Name/$SourceDirB_Name/;
		   $sourcefileB = $string;		   
		   print $sourcefileB. "\n";
		   
		   $string =~ s/$SourceDirB_Name/$TargetDir_Name/;
		   $targetfile = $string;
		   print $targetfile. "\n";
		
			# ֻ����ʽ���ļ�
			open(DATA1, $sourcefileA) or die "can't open dirA file  $sourcefileA";
			 
			# ֻ����ʽ���ļ�
			#open(DATA2, $sourcefileB) or print "can't open dirB file  $sourcefileB\n";
			 
			# �����ļ���д��
			open(DATA3, ">$targetfile") or die "can't open file";
			
			while(<DATA1>)
			{
				my $str = $_ ;
			   print DATA3 $str;
			   #print "$str";
			};
			if(open(DATA2, $sourcefileB)){
				while(<DATA2>)
				{
					my $str = $_ ;
				   print DATA3 $str;
				   #print "$str";
				}
			}else{
				print "can't open dirB file  $sourcefileB\n";
			}
			close( DATA1 );
			
			close( DATA2 );
			
			close( DATA3 );
		}	
		  	

	}
	
	print "end\n";

	closedir DIR;