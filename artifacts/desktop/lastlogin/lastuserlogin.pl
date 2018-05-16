#!/usr/bin/perl

use warnings;

$user_console = 0;
$user_num = 0;
$non_user_num = 0;
if (@ARGV == 0) {
    $user = "root"
} else {
    $user = $ARGV[0];
}
open (LASTLOGIN, "last -ad|");
@inputline = <LASTLOGIN>;
close (LASTLOGIN);
$/ = " ";
foreach $inline (@inputline) {
    chop ($inline);
    if ($inline ne "") {
        $sid = substr ($inline, 0, 9);
        $sid =~ s/ //g;
        if ($sid ne "wtmpbegi") {
            $session = substr ($inline, 9, 13);
            $session =~ s/ //g;
            @timedate = split (/\(/, substr ($inline, 22, 38));
            $logintime = $timedate[0];
            $where = substr($inline, 60, 40);
            if ($sid eq $user) {
                if ($session eq ":0" || $session =~ /tty/) {
                    $console[$user_console] = sprintf("Console log on by %s at %s \\n", $sid, $logintime);
                    $user_console++;
                } else {
                    if ($where eq "0.0.0.0") {
                        $remote[$user_num] = sprintf("Log on by %s at %s from Local Terminal Window \\n", $sid, $logintime);
                    } else {
                        $remote[$user_num] = sprintf("Log on by %s at %s from %s \\n", $sid, $logintime, $where);
                    }
                    $user_num++
                }
            } else {
                if ($where eq "0.0.0.0") {
                    $other_sessions[$non_user_num] = sprintf("Log on by %s at %s from Local Terminal Window \\n", $sid, $logintime);
                } else {
                    $other_sessions[$non_user_num] = sprintf("Log on by %s at %s from %s \\n", $sid, $logintime, $where);
                }
                $non_user_num++
            }
        }
    }
}
print ("Your Console Logins to this desktop\n");
for ($counter=0; $counter < 5 && $counter < $user_console; $counter++) {
    print ("$console[$counter]");
}
print ("\nYour Remote/Terminal Logins to this desktop\n");
for ($counter=0; $counter < 5 && $counter < $user_num; $counter++) {
    print ("$remote[$counter]");
}
print ("\nOther User Logins to this desktop\n");
for ($counter=0; $counter < 5 && $counter < $non_user_num; $counter++) {
    print ("$other_sessions[$counter]");
}
