package Devel::DebugAlarm;

use Devel::StackTrace;

our $alarm_longmess;

BEGIN {
    *CORE::GLOBAL::alarm = sub {
        $alarm_longmess = Devel::StackTrace->new(ignore_package => "Devel::DebugAlarm");
        return CORE::alarm(@_);
    }
}

$SIG{ALRM} = sub {
    die "Trapped alarm was set up at: " . $alarm_longmess->as_string;
    exit 1;
};

1;
