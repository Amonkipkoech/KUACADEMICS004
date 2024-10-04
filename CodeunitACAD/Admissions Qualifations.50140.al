/// <summary>
/// Codeunit Admissions Qualifations (ID 50140).
/// </summary>
codeunit 50140 "Admissions Qualifations"
{

    trigger OnRun()
    begin
    end;


    /// <summary>
    /// QualificationValidation.
    /// </summary>
    /// <param name="ApplicantNo">Code[20].</param>
    /// <param name="Programme">Code[20].</param>
    /// <returns>Return variable Qualify of type Boolean.</returns>
    procedure QualificationValidation(ApplicantNo: Code[20]; Programme: Code[20]) Qualify: Boolean
    var
        Prog: Record 61511;
        ProgEntry: Record 61467;
        RequiredCount: Integer;
        PassCount: Integer;
        AppRec: Record 61358;
    begin
        Qualify := FALSE;
        IF Prog.GET(Programme) THEN BEGIN
            IF AppRec.GET(ApplicantNo) THEN BEGIN
                IF AppRec."Points Acquired" >= Prog."Minimum Points" THEN
                    Qualify := TRUE;
            END;
        END;
    end;


    /// <summary>
    /// QualificationValidationSubjects.
    /// </summary>
    /// <param name="ApplicantNo">Code[20].</param>
    /// <param name="Programme">Code[20].</param>
    /// <returns>Return variable Qualify of type Boolean.</returns>
    procedure QualificationValidationSubjects(ApplicantNo: Code[20]; Programme: Code[20]) Qualify: Boolean
    var
        Prog: Record 61511;
        ProgEntry: Record 61467;
        RequiredCount: Integer;
        PassCount: Integer;
        AppRec: Record 61358;
        AppSubjects: Record 61362;
    begin
        Qualify := FALSE;
        IF Prog.GET(Programme) THEN BEGIN
            ProgEntry.RESET;
            ProgEntry.SETRANGE(ProgEntry.Programme, Programme);
            IF ProgEntry.FIND('-') THEN BEGIN
                RequiredCount := ProgEntry.COUNT;
                REPEAT
                    AppSubjects.RESET;
                    AppSubjects.SETRANGE(AppSubjects."Application No.", ApplicantNo);
                    AppSubjects.SETRANGE(AppSubjects."Subject Code", ProgEntry.Subject);
                    IF AppSubjects.FIND('-') THEN BEGIN
                        REPEAT
                            AppSubjects.CALCFIELDS(AppSubjects.Points);
                            IF AppSubjects.Points >= ProgEntry."Minimum Points" THEN
                                PassCount := PassCount + 1;
                        UNTIL AppSubjects.NEXT = 0;
                    END;
                UNTIL ProgEntry.NEXT = 0;
            END;
        END;

        IF PassCount >= RequiredCount THEN
            Qualify := TRUE;
    end;
    //procedure  
}

