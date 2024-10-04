table 61155 "ACA-Students Hostel Rooms"
{

    fields
    {
        field(1; "Line No"; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Space No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Room Spaces"."Space Code" WHERE("Hostel Code" = FIELD("Hostel No"),
                                                                  "Room Code" = FIELD("Room No"),
                                                                  Status = FILTER(Vaccant));

            trigger OnValidate()
            begin
                validateModification();
                CLEAR(settlementType);
                courseReg.RESET;
                courseReg.SETRANGE(courseReg."Student No.", Student);
                courseReg.SETRANGE(courseReg.Semester, Semester);
                //  courseReg.SETRANGE(courseReg."Academic Year","Academic Year");
                IF courseReg.FIND('-') THEN BEGIN
                    IF prog.GET(courseReg.Programmes) THEN BEGIN
                        IF prog."Special Programme" THEN
                            settlementType := settlementType::"Special Programme"
                        ELSE
                            IF courseReg."Settlement Type" = 'JAB' THEN
                                settlementType := settlementType::JAB
                            ELSE
                                IF courseReg."Settlement Type" = 'PSSP' THEN settlementType := settlementType::SSP;
                    END;
                END;
                CLEAR(billAmount);
                Rooms.RESET;
                Rooms.SETRANGE(Rooms."Hostel Code", "Hostel No");
                Rooms.SETRANGE(Rooms."Room Code", "Room No");
                IF Rooms.FIND('-') THEN BEGIN
                    Rooms.VALIDATE("Room Code");
                    // IF settlementType = settlementType::"Special Programme" THEN
                    //     billAmount := Rooms."Special Programme"
                    // ELSE
                    //     IF settlementType = settlementType::JAB THEN
                    //         billAmount := Rooms."JAB Fees"
                    //     ELSE
                    //         IF settlementType = settlementType::SSP THEN
                    //             billAmount := Rooms."SSP Fees"
                END;
                Charges := billAmount;
                /*
               IF billAmount>0 THEN BEGIN
               hstR.RESET;
               hstR.SETRANGE(hstR.Student,Student);
               hstR.SETRANGE(hstR."Line No","Line No");
               //hstR.SETRANGE(hstR."Space No","Space No");
               hstR.SETRANGE(hstR."Room No","Room No");
               hstR.SETRANGE(hstR."Hostel No","Hostel No");
               hstR.SETRANGE(hstR.Semester,Semester);
               hstR.SETRANGE(hstR.Cleared,FALSE);
               IF hstR.FIND('-') THEN BEGIN
                hstR.Charges:=billAmount;
                hstR.MODIFY;
                END;
                END;  */

            end;
        }
        field(3; "Room No"; Code[20])
        {
            TableRelation = "ACA-Hostel Block Rooms"."Room Code" WHERE("Hostel Code" = FIELD("Hostel No"));
            // Status = FILTER(Vaccant | "Partially Occupied"));

            trigger OnValidate()
            begin
                validateModification();
                roomSpaces.RESET;
                roomSpaces.SETRANGE(roomSpaces."Hostel Code", Rec."Hostel No");
                roomSpaces.SETRANGE(roomSpaces."Room Code", Rec."Room No");
                roomSpaces.SETFILTER(roomSpaces.Status, '=%1', roomSpaces.Status::Vaccant);
                IF roomSpaces.FIND('-') THEN BEGIN
                    "Space No" := roomSpaces."Space Code";
                    VALIDATE("Space No");
                END;
            end;
        }
        field(4; "Hostel No"; Code[20])
        {
            TableRelation = "ACA-Hostel Card"."Asset No";

            trigger OnValidate()
            begin
                validateModification();
                Rooms.RESET;
                Rooms.SETRANGE("Hostel Code", Rec."Hostel No");
                //  Rooms.SETFILTER(Rooms.Status, '=%1|%2', Rooms.Status::"Partially Occupied", Rooms.Status::Vaccant);
                IF Rooms.FIND('-') THEN BEGIN
                    "Room No" := Rooms."Room Code";
                    VALIDATE("Room No");
                END;
            end;
        }
        field(5; "Accomodation Fee"; Decimal)
        {
        }
        field(6; "Allocation Date"; Date)
        {
        }
        field(7; "Clearance Date"; Date)
        {
        }
        field(8; Charges; Decimal)
        {
        }
        field(9; Student; Code[20])
        {
            TableRelation = Customer."No.";

            trigger OnValidate()
            begin
                validateModification();
            end;
        }
        field(10; Billed; Boolean)
        {
        }
        field(11; "Billed Date"; Date)
        {
        }
        field(12; Semester; Code[20])
        {
            TableRelation = "ACA-Semesters".Code;
        }
        field(13; Cleared; Boolean)
        {
        }
        field(14; "Over Paid"; Boolean)
        {
        }
        field(15; "Over Paid Amt"; Decimal)
        {
        }
        field(16; "Eviction Code"; Code[20])
        {
            //TableRelation = "HRM-Disciplinary Cases".Code;
        }
        field(17; Gender; Option)
        {
            CalcFormula = Lookup(Customer.Gender WHERE("No." = FIELD(Student)));
            FieldClass = FlowField;
            OptionCaption = ',Male,Female';
            OptionMembers = ,Male,Female;
        }
        field(18; "Hostel Assigned"; Boolean)
        {
        }
        field(19; "Hostel Name"; Text[100])
        {
            CalcFormula = Lookup("Fixed Asset".Description WHERE("No." = FIELD("Hostel No")));
            FieldClass = FlowField;
        }
        field(50000; "Student Name"; Text[100])
        {
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD(Student)));
            FieldClass = FlowField;
        }
        field(50001; "Academic Year"; Code[30])
        {
            TableRelation = "ACA-Academic Year".Code;
        }
        field(50002; Session; Code[10])
        {
            TableRelation = "ACA-Intake".Code;
        }
        field(50003; Allocated; Boolean)
        {
        }
        field(50004; Select; Boolean)
        {
        }
        field(50005; Balance; Decimal)
        {
        }
        field(50006; "Transfer to Hostel No"; Code[20])
        {
            TableRelation = "ACA-Hostel Card"."Asset No" WHERE(Gender = FIELD(Gender));
        }
        field(50007; "Transfer to Room No"; Code[20])
        {
            TableRelation = "ACA-Hostel Block Rooms"."Room Code" WHERE("Hostel Code" = FIELD("Transfer to Hostel No"));
            //Status = FILTER(Vaccant|"Partially Occupied"));
        }
        field(50008; "Transfer to Space No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Room Spaces"."Space Code" WHERE("Hostel Code" = FIELD("Transfer to Hostel No"),
                                                                  "Room Code" = FIELD("Transfer to Room No"),
                                                                  Status = FILTER(Vaccant));

            trigger OnValidate()
            begin
                CLEAR(settlementType);
                courseReg.RESET;
                courseReg.SETRANGE(courseReg."Student No.", Student);
                courseReg.SETRANGE(courseReg.Semester, Semester);
                //  courseReg.SETRANGE(courseReg."Academic Year","Academic Year");
                IF courseReg.FIND('-') THEN BEGIN
                    IF prog.GET(courseReg.Programmes) THEN BEGIN
                        IF prog."Special Programme" THEN
                            settlementType := settlementType::"Special Programme"
                        ELSE
                            IF courseReg."Settlement Type" = 'JAB' THEN
                                settlementType := settlementType::JAB
                            ELSE
                                IF courseReg."Settlement Type" = 'SSP' THEN settlementType := settlementType::SSP;
                    END;
                END;
                CLEAR(billAmount);
                Rooms.RESET;
                Rooms.SETRANGE(Rooms."Hostel Code", "Hostel No");
                Rooms.SETRANGE(Rooms."Room Code", "Room No");
                IF Rooms.FIND('-') THEN BEGIN
                    // IF settlementType = settlementType::"Special Programme" THEN
                    //     billAmount := Rooms."Special Programme"
                    // ELSE
                    //     IF settlementType = settlementType::JAB THEN
                    //         billAmount := Rooms."JAB Fees"
                    //     ELSE
                    //         IF settlementType = settlementType::SSP THEN
                    //             billAmount := Rooms."SSP Fees"
                END;

                IF billAmount > 0 THEN Charges := billAmount;
            end;
        }
        field(50009; Transfered; Boolean)
        {
        }
        field(50010; Reversed; Boolean)
        {
        }
        field(50011; Switched; Boolean)
        {
        }
        field(50012; "Switched from Hostel No"; Code[20])
        {
            TableRelation = "ACA-Hostel Card"."Asset No" WHERE(Gender = FIELD(Gender));
        }
        field(50013; "Switched from Room No"; Code[20])
        {
            TableRelation = "ACA-Hostel Block Rooms"."Room Code" WHERE("Hostel Code" = FIELD("Transfer to Hostel No"));
            //  Status=FILTER('Vaccant|Partially Occupied'));
        }
        field(50014; "Switched from Space No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Room Spaces"."Space Code" WHERE("Hostel Code" = FIELD("Transfer to Hostel No"),
                                                                  "Room Code" = FIELD("Transfer to Room No"),
                                                                  Status = FILTER(Vaccant));

            trigger OnValidate()
            begin
                CLEAR(settlementType);
                courseReg.RESET;
                courseReg.SETRANGE(courseReg."Student No.", Student);
                courseReg.SETRANGE(courseReg.Semester, Semester);
                //  courseReg.SETRANGE(courseReg."Academic Year","Academic Year");
                IF courseReg.FIND('-') THEN BEGIN
                    IF prog.GET(courseReg.Programmes) THEN BEGIN
                        IF prog."Special Programme" THEN
                            settlementType := settlementType::"Special Programme"
                        ELSE
                            IF courseReg."Settlement Type" = 'JAB' THEN
                                settlementType := settlementType::JAB
                            ELSE
                                IF courseReg."Settlement Type" = 'SSP' THEN settlementType := settlementType::SSP;
                    END;
                END;
                CLEAR(billAmount);
                Rooms.RESET;
                Rooms.SETRANGE(Rooms."Hostel Code", "Hostel No");
                Rooms.SETRANGE(Rooms."Room Code", "Room No");
                IF Rooms.FIND('-') THEN BEGIN
                    // IF settlementType = settlementType::"Special Programme" THEN
                    //     billAmount := Rooms."Special Programme"
                    // ELSE
                    //     IF settlementType = settlementType::JAB THEN
                    //         billAmount := Rooms."JAB Fees"
                    //     ELSE
                    //         IF settlementType = settlementType::SSP THEN
                    //             billAmount := Rooms."SSP Fees"
                END;

                IF billAmount > 0 THEN Charges := billAmount;
            end;
        }
        field(50015; "Switched to Hostel No"; Code[20])
        {
            TableRelation = "ACA-Hostel Card"."Asset No" WHERE(Gender = FIELD(Gender));
        }
        field(50016; "Switched to Room No"; Code[20])
        {
            TableRelation = "ACA-Hostel Block Rooms"."Room Code" WHERE("Hostel Code" = FIELD("Switched to Hostel No"));
            //Status=FILTER('Fully Occupied|Partially Occupied'));
        }
        field(50017; "Switched to Space No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Room Spaces"."Space Code" WHERE("Hostel Code" = FIELD("Switched to Hostel No"),
                                                                  "Room Code" = FIELD("Switched to Room No"),
                                                                  Status = FILTER("Fully Occupied"));

            trigger OnValidate()
            begin
                CLEAR(settlementType);
                courseReg.RESET;
                courseReg.SETRANGE(courseReg."Student No.", Student);
                courseReg.SETRANGE(courseReg.Semester, Semester);
                //  courseReg.SETRANGE(courseReg."Academic Year","Academic Year");
                IF courseReg.FIND('-') THEN BEGIN
                    IF prog.GET(courseReg.Programmes) THEN BEGIN
                        IF prog."Special Programme" THEN
                            settlementType := settlementType::"Special Programme"
                        ELSE
                            IF courseReg."Settlement Type" = 'JAB' THEN
                                settlementType := settlementType::JAB
                            ELSE
                                IF courseReg."Settlement Type" = 'SSP' THEN settlementType := settlementType::SSP;
                    END;
                END;
                CLEAR(billAmount);
                Rooms.RESET;
                Rooms.SETRANGE(Rooms."Hostel Code", "Hostel No");
                Rooms.SETRANGE(Rooms."Room Code", "Room No");
                IF Rooms.FIND('-') THEN BEGIN
                    // IF settlementType = settlementType::"Special Programme" THEN
                    //     billAmount := Rooms."Special Programme"
                    // ELSE
                    // IF settlementType = settlementType::JAB THEN
                    //     billAmount := Rooms."JAB Fees"
                    // ELSE
                    //     IF settlementType = settlementType::SSP THEN
                    //         billAmount := Rooms."SSP Fees"
                END;

                IF billAmount > 0 THEN Charges := billAmount;
            end;
        }
        field(50018; "Transfed from Hostel No"; Code[20])
        {
            TableRelation = "ACA-Hostel Card"."Asset No";
            // WHERE("JAB Fees"=FILTER(4000),
            // "SSP Fees"=FILTER(8000),
            // Gender=FIELD(Gender));
        }
        field(50019; "Transfed from Room No"; Code[20])
        {
            TableRelation = "ACA-Hostel Block Rooms"."Room Code" WHERE("Hostel Code" = FIELD("Transfer to Hostel No"));
            //Status=FILTER('Vaccant|Partially Occupied'));
        }
        field(50020; "Transfed from Space No"; Code[20])
        {
            NotBlank = true;
            TableRelation = "ACA-Room Spaces"."Space Code" WHERE("Hostel Code" = FIELD("Transfer to Hostel No"),
                                                                  "Room Code" = FIELD("Transfer to Room No"),
                                                                  Status = FILTER(Vaccant));

            trigger OnValidate()
            begin
                CLEAR(settlementType);
                courseReg.RESET;
                courseReg.SETRANGE(courseReg."Student No.", Student);
                courseReg.SETRANGE(courseReg.Semester, Semester);
                //  courseReg.SETRANGE(courseReg."Academic Year","Academic Year");
                IF courseReg.FIND('-') THEN BEGIN
                    IF prog.GET(courseReg.Programmes) THEN BEGIN
                        IF prog."Special Programme" THEN
                            settlementType := settlementType::"Special Programme"
                        ELSE
                            IF courseReg."Settlement Type" = 'JAB' THEN
                                settlementType := settlementType::JAB
                            ELSE
                                IF courseReg."Settlement Type" = 'SSP' THEN settlementType := settlementType::SSP;
                    END;
                END;
                CLEAR(billAmount);
                Rooms.RESET;
                Rooms.SETRANGE(Rooms."Hostel Code", "Hostel No");
                Rooms.SETRANGE(Rooms."Room Code", "Room No");
                IF Rooms.FIND('-') THEN BEGIN
                    //IF settlementType=settlementType::"Special Programme" THEN
                    //billAmount:=Rooms."Special Programme"
                    //ELSE IF settlementType=settlementType::JAB THEN
                    // billAmount:=Rooms."JAB Fees"
                    //ELSE IF settlementType=settlementType::SSP THEN
                    //billAmount:=Rooms."SSP Fees"
                END;

                IF billAmount > 0 THEN Charges := billAmount;
            end;
        }
        field(50021; Status; Option)
        {
            OptionCaption = 'Booking,Allocated';
            OptionMembers = Booking,Allocated;
        }
        field(50022; "Invoice Printed"; Boolean)
        {
        }
        field(50026; "Invoice Printed By"; Code[20])
        {
        }
        field(50027; "Swithed By"; Code[20])
        {
        }
        field(50028; "Transfered By"; Code[20])
        {
        }
        field(50029; "Reverse Allocated By"; Code[20])
        {
        }
        field(50030; "Key Allocated"; Boolean)
        {
        }
        field(50031; "Key No"; Code[10])
        {
        }
        field(50032; "Allocated By"; Code[30])
        {
        }
        field(50033; "Time allocated"; Time)
        {
        }
        field(50034; "Time Reversed"; Time)
        {
        }
        field(50035; "Time Transfered"; Time)
        {
        }
        field(50036; "Time Swithed"; Time)
        {
        }
        field(50037; "Date Reversed"; Date)
        {
        }
        field(50038; "Date Transfered"; Date)
        {
        }
        field(50039; "Date Switched"; Date)
        {
        }
        field(50040; "Key Allocated By"; Code[30])
        {
        }
        field(50041; "Key Allocated Time"; Time)
        {
        }
        field(50042; "Key Allocated Date"; Date)
        {
        }
        field(50044; "Reversed By"; Code[100])
        {
        }
        field(50045; "Switched By"; Code[100])
        {
        }
        field(50046; "Start Date"; Date)
        {
            CalcFormula = Lookup("ACA-Course Registration"."Registration Date" WHERE("Student No." = FIELD(Student),
                                                                                      Semester = FIELD(Semester)));
            FieldClass = FlowField;
        }
        field(50047; "End Date"; Date)
        {
            // CalcFormula = Lookup("ACA-Academic Year Schedule"."End Date" WHERE (Semester=FIELD(Semester)));
            // FieldClass = FlowField;
        }
        field(50048; "Settlement Type"; Code[20])
        {
            CalcFormula = Lookup("ACA-Course Registration"."Settlement Type" WHERE("Student No." = FIELD(Student),
                                                                                    Semester = FIELD(Semester)));
            FieldClass = FlowField;
        }
        field(50049; "Campus Code"; Code[20])
        {
            CalcFormula = Lookup(Customer."Global Dimension 1 Code" WHERE("No." = FIELD(Student)));
            FieldClass = FlowField;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = FILTER(1));
        }
        field(50050; Valid; Boolean)
        {
            CalcFormula = Exist("ACA-Hostel Ledger" WHERE("Hostel No" = FIELD("Hostel No"),
                                                           "Room No" = FIELD("Room No"),
                                                           "Space No" = FIELD("Space No"),
                                                           "Student No" = FIELD(Student),
                                                           Semester = FIELD(Semester)));
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; Student, "Line No")
        {
        }
        key(Key2; "Hostel No")
        {
        }
        key(Key3; "Line No")
        {
        }
        key(Key4; "Allocation Date")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        //validateModification();
    end;

    trigger OnInsert()
    begin
        //AcadYear.RESET;
        //AcadYear.SETRANGE(AcadYear.Current,TRUE);
        //IF AcadYear.FIND('-') THEN BEGIN
        //Sem.RESET;
        //Sem.SETRANGE(Sem."Current Semester",TRUE);
        //IF Sem.FIND('-') THEN BEGIN
        courseReg.RESET;
        courseReg.SETRANGE(courseReg."Student No.", Student);
        //  courseReg.SETRANGE(courseReg."Academic Year",AcadYear.Code);
        courseReg.SETRANGE(courseReg.Semester, Sem.Code);
        //IF NOT (courseReg.FIND('-')) THEN ERROR('The student has not been registered for the current Academic Year.');
        "Academic Year" := AcadYear.Code;
        Semester := Sem.Code;
        // Pick Accommondation fees and the student balance.
        IF cust.GET(Student) THEN BEGIN
            cust.CALCFIELDS(cust."Balance (LCY)");
            Balance := cust."Balance (LCY)";
        END;
        stageCharges.RESET;
        stageCharges.SETRANGE(stageCharges."Programme Code", courseReg.Programmes);
        stageCharges.SETRANGE(stageCharges."Stage Code", courseReg.Stage);
        stageCharges.SETRANGE(stageCharges."Settlement Type", courseReg."Settlement Type");
        stageCharges.SETRANGE(stageCharges.Code, 'ACCOMMODATION');
        IF stageCharges.FIND('-') THEN BEGIN
            //  Charges:=stageCharges.Amount;
            // Billed:=stageCharges.Amount;
            IF cust."Balance (LCY)" < 0 THEN BEGIN
                "Over Paid" := TRUE;
                "Over Paid Amt" := cust."Balance (LCY)" - stageCharges.Amount;
            END;

        END;// ELSE ERROR('Accommodation missing in the fee setup for: Prog:-'+courseReg.Programme+' Stage:- '+courseReg.Stage+' Type:- '+courseReg."Settlement Type");
            //  IF courseReg."Settlement Type"='JAB' THEN Charges:=4000;
            //  IF courseReg."Settlement Type"='SSP' THEN Charges:=8000;
            //END ELSE ERROR('The Current Semester has not been set.\Consult the system administrator.');
            //END ELSE ERROR('The Current academic year has not been set.');
    end;

    var
        courseReg: Record 61532;
        AcadYear: Record 61382;
        Sem: Record 61692;
        stageCharges: Record 61533;
        cust: Record 18;
        roomSpaces: Record 61824;
        Rooms: Record 61823;
        prog: Record 61511;
        settlementType: Option " ",JAB,SSP,"Special Programme";
        billAmount: Decimal;
        HostRec: Record 61162;
        hstR: Record 61155;
        ACAHostelLedger: Record 61163;

    local procedure validateModification()
    begin
        IF ((Allocated)) THEN BEGIN
            ACAHostelLedger.RESET;
            ACAHostelLedger.SETRANGE("Space No", Rec."Space No");
            ACAHostelLedger.SETRANGE("Room No", Rec."Room No");
            ACAHostelLedger.SETRANGE("Hostel No", Rec."Hostel No");
            IF ACAHostelLedger.FIND('-') THEN
                ERROR('Deletion/Modification of allocated Record is not allowed');
        END;
    end;
}

