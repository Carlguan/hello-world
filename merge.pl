#!/usr/bin/perl
#use utf8;
 
	opendir (DIR, '.') or die "can't open dir, $!";
	$SubDirNum = 0;
#test
	$SourceDirA_Name='01新词表/';
	$SourceDirB_Name='02老词表/';
	$TargetDir_Name='03整合词表/';

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

	mkdir ($TargetDir_Name); #建立目标目录
	
	for($a=2;$a<$SubDirNum;$a++){   #每个子目录分别整合
	  print "====$SubDir_Name[$a]\n";
	  mkdir ($TargetDir_Name.$SubDir_Name[$a]);
	  
	  #找出当前目录的TXT文档
		$dir = "$SourceDirA_Name"."$SubDir_Name[$a]"."*.txt";  
		print "====  列出  $dir \n";
		@files = glob( $dir );
		
		#逐个TXT文档处理
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
		
			# 只读方式打开文件
			open(DATA1, $sourcefileA) or die "can't open dirA file  $sourcefileA";
			 
			# 只读方式打开文件
			#open(DATA2, $sourcefileB) or print "can't open dirB file  $sourcefileB\n";
			 
			# 打开新文件并写入
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