table 61771 "CAT-Cafe Daily Duty Header"
{

    fields
    {
        field(1; Date; Date)
        {

            trigger OnValidate()
            begin
                IF Date = 0D THEN EXIT;

                IF DATE2DMY(Date, 2) = 1 THEN
                    Month := 'JANUARY'
                ELSE
                    IF DATE2DMY(Date, 2) = 2 THEN
                        Month := 'FEBRUARY'
                    ELSE
                        IF DATE2DMY(Date, 2) = 3 THEN
                            Month := 'MARCH'
                        ELSE
                            IF DATE2DMY(Date, 2) = 4 THEN
                                Month := 'APRIL'
                            ELSE
                                IF DATE2DMY(Date, 2) = 5 THEN
                                    Month := 'MAY'
                                ELSE
                                    IF DATE2DMY(Date, 2) = 6 THEN
                                        Month := 'JUNE'
                                    ELSE
                                        IF DATE2DMY(Date, 2) = 7 THEN
                                            Month := 'JULY'
                                        ELSE
                                            IF DATE2DMY(Date, 2) = 8 THEN
                                                Month := 'AUGUST'
                                            ELSE
                                                IF DATE2DMY(Date, 2) = 9 THEN
                                                    Month := 'SEPTEMBER'
                                                ELSE
                                                    IF DATE2DMY(Date, 2) = 10 THEN
                                                        Month := 'OCTOBER'
                                                    ELSE
                                                        IF DATE2DMY(Date, 2) = 11 THEN
                                                            Month := 'NOVEMBER'
                                                        ELSE
                                                            IF DATE2DMY(Date, 2) = 12 THEN
                                                                Month := 'DECEMBER';

                Year := FORMAT(DATE2DMY(Date, 3));
            end;
        }
        field(2; Day; Option)
        {
            OptionCaption = ' ,MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY,SATURDAY,SUNDAY';
            OptionMembers = " ",MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY,SATURDAY,SUNDAY;
        }
        field(3; "Duty Header Statement"; Text[100])
        {
        }
        field(4; "Footer Statement"; Text[100])
        {
        }
        field(5; Month; Code[10])
        {
        }
        field(6; Year; Code[10])
        {
        }
    }

    keys
    {
        key(Key1; Date, Day)
        {
        }
    }

    fieldgroups
    {
    }

    var
        mth: Code[10];
        yrs: Code[10];
}

