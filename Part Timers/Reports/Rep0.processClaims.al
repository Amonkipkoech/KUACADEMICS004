report 52057 processClaims
{
    ApplicationArea = All;
    Caption = 'processClaims';
    UsageCategory = ReportsAndAnalysis;
    ProcessingOnly = true;
    dataset
    {
        dataitem("ACA-Semester"; "ACA-Semester")
        {
            RequestFilterFields = Code;
            column(Code; Code)
            {

            }
            column(Description; Description)
            {

            }
            dataitem(ACAUnitsOffered; "ACA-Units Offered")
            {
                DataItemLink = Semester = field(Code);
                column(AcademicYear; "Academic Year")
                {
                }
                column(Campus; Campus)
                {
                }
                column(Day; Day)
                {
                }
                column(Department; Department)
                {
                }
                column(Lecturer; Lecturer)
                {
                }
                column(ModeofStudy; ModeofStudy)
                {
                }
                column(ProgramName; "Program Name")
                {
                }
                column(Programs; Programs)
                {
                }
                column(RegisteredStudents; "Registered Students")
                {
                }
                column(Semester; Semester)
                {
                }
                column(Stream; Stream)
                {
                }
                column(TimeSlot; TimeSlot)
                {
                }
                column(UnitBaseCode; "Unit Base Code")
                {
                }

            }
            trigger OnAfterGetRecord()
            begin
                hrEmp.Reset();
                hrEmp.SetRange("No.", '00106');
                hrEmp.SetRange(Lecturer, true);
                if hrEmp.Find('-') then begin
                    repeat
                        unitsOff.Reset();
                        unitsOff.SetRange("Unit Base Code", ACAUnitsOffered."Unit Base Code");
                        if unitsOff.Find('-') then begin
                            prog.Reset();
                            prog.SetRange(Code, unitsOff.Programs);
                            if prog.Find('-') then begin
                                level := Format(prog.Levels);
                            end;
                            // totunits := unitsOff.Count();
                            // if totunits > hrEmp."Allowed Workload" then begin
                            //     remUnits := totunits - hrEmp."Allowed Workload"
                            // end;
                            repeat
                                //remRec := totunits - 1;
                                //if remRec > remUnits then begin
                                unitsOff.CalcFields("Registered Students");
                                studNo := unitsOff."Registered Students";
                                if unitsOff.ModeofStudy = 'FULL TIME' then begin
                                    ascUnit.Reset();
                                    ascUnit.SetRange(UnitBaseCode, unitsOff."Unit Base Code");
                                    if not ascUnit.Find('-') then begin
                                        ftunitsCount := ftunitsCount + 1;
                                        rates.Reset();
                                        rates.SetRange(ProgrammeLevel, prog.Levels);
                                        rates.SetRange(modeofStudy, unitsOff.ModeofStudy);
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
                            //end else begin
                            // rates.Reset();
                            // rates.SetRange(ProgrammeLevel, prog.Levels);
                            // rates.SetRange(modeofStudy, 'PART TIME');
                            // rates.SetRange(designation, hrEmp.designation);
                            // if rates.Find('-') then begin
                            //     if studNo < rates.quorum then
                            //         charge := (studNo / rates.quorum) * rates.Amount
                            //     else
                            //         charge := rates.Amount;
                            // end;
                            // cummChargePT := cummChargePT + charge;
                            //end;


                            until unitsOff.Next() = 0;
                            grandTot := cummChargeFT + cummChargePT;
                            //insert
                            firstInstall := grandTot * 0.3;
                            secInstall := grandTot * 0.3;
                            thirdInstall := grandTot * 0.4;
                            ptClaimLines.Init();
                            ptClaimLines.lecNo := hrEmp."No.";
                            ptClaimLines.unitBaseCode := unitsOff."Unit Base Code";
                            ptClaimLines.lecName := hrEmp."Full Name";
                            ptClaimLines.semester := 'JAN-APR24';
                            ptClaimLines.vcampus := hrEmp.Campus;
                            ptClaimLines.modeofStudy := modeofStudy;
                            ptClaimLines.studentsNum := studNo;
                            ptClaimLines.Level := level;
                            ptClaimLines.amount := grandTot;
                            ptClaimLines.firstInstallment := firstInstall;
                            ptClaimLines.secondInstallment := secInstall;
                            ptClaimLines.thirdInstallment := thirdInstall;
                            ptClaimLines.grandTotal := grandTot;
                            ptClaimLines.Insert();

                        end;



                    until hrEmp.Next() = 0;
                end;
            end;
        }

    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
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
}
