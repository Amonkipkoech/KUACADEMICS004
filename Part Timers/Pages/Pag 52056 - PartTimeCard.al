page 52056 "Part Time Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = partTimeHead;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(academicYr; Rec.academicYr)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the academicYr field.';
                }
                field(semester; Rec.semester)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the semester field.';
                }
                field(createdBy; Rec.createdBy)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the createdBy field.';
                }
                field(dateCreated; Rec.dateCreated)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the dateCreated field.';
                }
            }
            part(lines; ptClaimLines)
            {
                SubPageLink = semester = field(semester);
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    generateClaim();
                end;
            }
            action(report)
            {
                ApplicationArea = All;
                RunObject = report processClaims;
            }
        }
    }

    var
        hrEmp: Record "HRM-Employee (D)";
        unitsOff: Record "ACA-Units Offered";
        rates: Record ptRates;
        ftunitsCount: Decimal;
        ptunitsCount: Decimal;
        remUnits: Decimal;

        ascUnit: Record acaAssosiateUnits;
        prog: Record "ACA-Programme";
        level: Text;
        modeofStudy: Text;
        charge: Decimal;
        ptClaimLines: Record ptClaimLines;
        firstInstall: Decimal;
        secInstall: Decimal;
        thirdInstall: Decimal;
        studNo: Decimal;
        cummChargeFT: Decimal;
        totunits: Decimal;
        remRec: Decimal;
        cummChargePT: Decimal;
        grandTot: Decimal;
        unitsOff2: Record "ACA-Units Offered";
        lecunits: Record "ACA-Lecturers Units";
        uniqueUnit: Text;

    procedure separate()
    begin
        unitsOff.Reset();
        unitsOff.SetRange(semester, 'JAN-APR24');
        unitsOff.SetRange(ModeofStudy, 'FULL TIME');
        unitsOff.SetRange(Lecturer, '00106');
        if unitsOff.Find('-') then begin

        end;


    end;

    procedure generateClaim()
    begin
        hrEmp.Reset();
        hrEmp.SetRange(hrEmp.Status, hrEmp.Status::Active);
        hrEmp.SetRange(Lecturer, true);
        if hrEmp.Find('-') then begin
            repeat
                remRec := remRec + 1;
                lecunits.Reset();
                lecunits.SetRange(Lecturer, hrEmp."No.");
                lecunits.SetRange(Semester, 'JAN-APR24');
                if lecunits.Find('-') then begin
                    repeat

                        lecunits.CalcFields(unique);
                        uniqueUnit := lecunits.unique;
                        unitsOff.Reset();
                        unitsOff.SetRange("Unit Base Code", uniqueUnit);
                        unitsOff.SetRange(modeofStudy, lecunits.ModeOfStudy);
                        if unitsOff.Find('-') then begin
                            prog.Reset();
                            prog.SetRange(Code, unitsOff.Programs);
                            if prog.Find('-') then begin
                                level := Format(prog.Levels);
                            end;
                            repeat
                                totunits := totunits + 1;
                                unitsOff.CalcFields("Registered Students");
                                studNo := unitsOff."Registered Students";
                                ascUnit.Reset();
                                ascUnit.SetRange("Associated Unit", unitsOff."Unit Base Code");
                                if not ascUnit.Find('-') then begin
                                    if (hrEmp."Employee Category" = 'FULL TIME') AND (totunits < hrEmp."Allowed Workload") then begin
                                        rates.Reset();
                                        rates.SetRange(ProgrammeLevel, prog.Levels);
                                        rates.SetRange(modeofStudy, 'FULL TIME');
                                        rates.SetRange(designation, hrEmp.designation);
                                        if rates.Find('-') then begin
                                            if studNo < rates.quorum then
                                                charge := (studNo / rates.quorum) * rates.Amount
                                            else
                                                charge := rates.Amount;
                                        end;
                                    end else
                                        if (hrEmp."Employee Category" = 'FULL TIME') AND (totunits > hrEmp."Allowed Workload") then begin
                                            rates.Reset();
                                            rates.SetRange(ProgrammeLevel, prog.Levels);
                                            rates.SetRange(modeofStudy, 'PART TIME');
                                            rates.SetRange(designation, hrEmp.designation);
                                            if rates.Find('-') then begin
                                                if studNo < rates.quorum then
                                                    charge := (studNo / rates.quorum) * rates.Amount
                                                else
                                                    charge := rates.Amount;
                                            end;
                                        end;
                                end;
                                cummChargeFT := cummChargeFT + charge;
                            until unitsOff.Next() = 0;
                            grandTot := cummChargeFT;
                            firstInstall := grandTot * 0.3;
                            secInstall := grandTot * 0.3;
                            thirdInstall := grandTot * 0.4;
                            ptClaimLines.Reset();
                            ptClaimLines.SetRange(lecNo, hrEmp."No.");
                            ptClaimLines.SetRange(unitBaseCode, unitsOff."Unit Base Code");
                            ptClaimLines.SetRange(modeofStudy, unitsOff.ModeofStudy);
                            ptClaimLines.SetRange(semester, unitsOff.Semester);
                            ptClaimLines.SetRange(stream, unitsOff.Stream);
                            if not ptClaimLines.Find('-') then begin
                                ptClaimLines.Init();
                                ptClaimLines.entry := remRec;
                                ptClaimLines.lecNo := hrEmp."No.";
                                ptClaimLines.unitBaseCode := unitsOff."Unit Base Code";
                                ptClaimLines.Day := unitsOff.Day;
                                ptClaimLines.TimeSlot := unitsOff.TimeSlot;
                                ptClaimLines.stream := unitsOff.Stream;
                                ptClaimLines.lecName := hrEmp."Full Name";
                                ptClaimLines.semester := 'JAN-APR24';
                                ptClaimLines.vcampus := unitsOff.Campus;
                                ptClaimLines.modeofStudy := unitsOff.ModeofStudy;
                                ptClaimLines.studentsNum := studNo;
                                ptClaimLines.Level := level;
                                ptClaimLines.amount := grandTot;
                                ptClaimLines.firstInstallment := firstInstall;
                                ptClaimLines.secondInstallment := secInstall;
                                ptClaimLines.thirdInstallment := thirdInstall;
                                ptClaimLines.grandTotal := grandTot;
                                ptClaimLines.Insert();
                            end;
                            Clear(cummChargeFT);

                        end;
                    // //Part-time
                    // unitsOff.Reset();
                    // unitsOff.SetRange("Unit Base Code", uniqueUnit);
                    // unitsOff.SetRange(modeofStudy, 'PART TIME');
                    // ptClaimLines.SetRange(modeofStudy, unitsOff.ModeofStudy);
                    // if unitsOff.Find('-') then begin
                    //     prog.Reset();
                    //     prog.SetRange(Code, unitsOff.Programs);
                    //     if prog.Find('-') then begin
                    //         level := Format(prog.Levels);
                    //     end;
                    //     repeat
                    //         totunits := totunits + 1;
                    //         unitsOff.CalcFields("Registered Students");
                    //         studNo := unitsOff."Registered Students";
                    //         ascUnit.Reset();
                    //         ascUnit.SetRange("Associated Unit", unitsOff."Unit Base Code");
                    //         if not ascUnit.Find('-') then begin
                    //             if (hrEmp."Employee Category" = 'FULL TIME') AND (totunits > hrEmp."Allowed Workload") then begin
                    //                 rates.Reset();
                    //                 rates.SetRange(ProgrammeLevel, prog.Levels);
                    //                 rates.SetRange(modeofStudy, 'PART TIME');
                    //                 rates.SetRange(designation, hrEmp.designation);
                    //                 if rates.Find('-') then begin
                    //                     if studNo < rates.quorum then
                    //                         charge := (studNo / rates.quorum) * rates.Amount
                    //                     else
                    //                         charge := rates.Amount;
                    //                 end;
                    //             end else
                    //                 if hrEmp."Employee Category" = 'PART TIME' then begin
                    //                     rates.Reset();
                    //                     rates.SetRange(ProgrammeLevel, prog.Levels);
                    //                     rates.SetRange(modeofStudy, 'PART TIME');
                    //                     rates.SetRange(designation, hrEmp.designation);
                    //                     if rates.Find('-') then begin
                    //                         if studNo < rates.quorum then
                    //                             charge := (studNo / rates.quorum) * rates.Amount
                    //                         else
                    //                             charge := rates.Amount;
                    //                     end;
                    //                 end;
                    //         end;
                    //         cummChargeFT := cummChargeFT + charge;
                    //     until unitsOff.Next() = 0;
                    //     grandTot := cummChargeFT;
                    //     firstInstall := grandTot * 0.3;
                    //     secInstall := grandTot * 0.3;
                    //     thirdInstall := grandTot * 0.4;
                    //     ptClaimLines.Reset();
                    //     ptClaimLines.SetRange(lecNo, hrEmp."No.");
                    //     ptClaimLines.SetRange(unitBaseCode, unitsOff."Unit Base Code");
                    //     ptClaimLines.SetRange(semester, unitsOff.Semester);
                    //     ptClaimLines.SetRange(stream, unitsOff.Stream);
                    //     ptClaimLines.SetRange(modeofStudy, unitsOff.ModeofStudy);
                    //     if not ptClaimLines.Find('-') then begin
                    //         ptClaimLines.Init();
                    //         ptClaimLines.entry := ptClaimLines.entry + 100;
                    //         ptClaimLines.lecNo := hrEmp."No.";
                    //         ptClaimLines.unitBaseCode := unitsOff."Unit Base Code";
                    //         ptClaimLines.stream := unitsOff.Stream;
                    //         ptClaimLines.lecName := hrEmp."Full Name";
                    //         ptClaimLines.semester := 'JAN-APR24';
                    //         ptClaimLines.vcampus := hrEmp.Campus;
                    //         ptClaimLines.modeofStudy := unitsOff.ModeofStudy;
                    //         ptClaimLines.studentsNum := studNo;
                    //         ptClaimLines.Level := level;
                    //         ptClaimLines.amount := grandTot;
                    //         ptClaimLines.firstInstallment := firstInstall;
                    //         ptClaimLines.secondInstallment := secInstall;
                    //         ptClaimLines.thirdInstallment := thirdInstall;
                    //         ptClaimLines.grandTotal := grandTot;
                    //         ptClaimLines.Insert();
                    //     end;
                    //     Clear(cummChargeFT);

                    // end;
                    // ///ODEL
                    // unitsOff.Reset();
                    // unitsOff.SetRange("Unit Base Code", uniqueUnit);
                    // unitsOff.SetRange(modeofStudy, 'ODEL');
                    // if unitsOff.Find('-') then begin
                    //     prog.Reset();
                    //     prog.SetRange(Code, unitsOff.Programs);
                    //     if prog.Find('-') then begin
                    //         level := Format(prog.Levels);
                    //     end;
                    //     repeat
                    //         totunits := totunits + 1;
                    //         unitsOff.CalcFields("Registered Students");
                    //         studNo := unitsOff."Registered Students";
                    //         ascUnit.Reset();
                    //         ascUnit.SetRange("Associated Unit", unitsOff."Unit Base Code");
                    //         if not ascUnit.Find('-') then begin
                    //             if (hrEmp."Employee Category" = 'FULL TIME') AND (totunits > hrEmp."Allowed Workload") then begin
                    //                 rates.Reset();
                    //                 rates.SetRange(ProgrammeLevel, prog.Levels);
                    //                 rates.SetRange(modeofStudy, 'PART TIME');
                    //                 rates.SetRange(designation, hrEmp.designation);
                    //                 if rates.Find('-') then begin
                    //                     if studNo < rates.quorum then
                    //                         charge := (studNo / rates.quorum) * rates.Amount
                    //                     else
                    //                         charge := rates.Amount;
                    //                 end;
                    //             end else
                    //                 if hrEmp."Employee Category" = 'PART TIME' then begin
                    //                     rates.Reset();
                    //                     rates.SetRange(ProgrammeLevel, prog.Levels);
                    //                     rates.SetRange(modeofStudy, 'PART TIME');
                    //                     rates.SetRange(designation, hrEmp.designation);
                    //                     if rates.Find('-') then begin
                    //                         if studNo < rates.quorum then
                    //                             charge := (studNo / rates.quorum) * rates.Amount
                    //                         else
                    //                             charge := rates.Amount;
                    //                     end;
                    //                 end;
                    //         end;
                    //         cummChargeFT := cummChargeFT + charge;
                    //     until unitsOff.Next() = 0;
                    //     grandTot := cummChargeFT;
                    //     firstInstall := grandTot * 0.3;
                    //     secInstall := grandTot * 0.3;
                    //     thirdInstall := grandTot * 0.4;
                    //     ptClaimLines.Reset();
                    //     ptClaimLines.SetRange(lecNo, hrEmp."No.");
                    //     ptClaimLines.SetRange(unitBaseCode, unitsOff."Unit Base Code");
                    //     ptClaimLines.SetRange(semester, unitsOff.Semester);
                    //     ptClaimLines.SetRange(stream, unitsOff.Stream);
                    //     ptClaimLines.SetRange(modeofStudy, unitsOff.ModeofStudy);
                    //     if not ptClaimLines.Find('-') then begin
                    //         ptClaimLines.Init();
                    //         ptClaimLines.entry := ptClaimLines.entry + 1000;
                    //         ptClaimLines.lecNo := hrEmp."No.";
                    //         ptClaimLines.unitBaseCode := unitsOff."Unit Base Code";
                    //         ptClaimLines.stream := unitsOff.Stream;
                    //         ptClaimLines.lecName := hrEmp."Full Name";
                    //         ptClaimLines.semester := 'JAN-APR24';
                    //         ptClaimLines.vcampus := hrEmp.Campus;
                    //         ptClaimLines.modeofStudy := unitsOff.ModeofStudy;
                    //         ptClaimLines.studentsNum := studNo;
                    //         ptClaimLines.Level := level;
                    //         ptClaimLines.amount := grandTot;
                    //         ptClaimLines.firstInstallment := firstInstall;
                    //         ptClaimLines.secondInstallment := secInstall;
                    //         ptClaimLines.thirdInstallment := thirdInstall;
                    //         ptClaimLines.grandTotal := grandTot;
                    //         ptClaimLines.Insert();
                    //     end;
                    //     Clear(cummChargeFT);

                    // end;


                    until lecunits.Next() = 0;

                end;

            until hrEmp.Next() = 0;
        end;
    end;

}
