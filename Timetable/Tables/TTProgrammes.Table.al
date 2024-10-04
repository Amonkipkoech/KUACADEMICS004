/// <summary>
/// Table TT-Programmes (ID 74504).
/// </summary>
table 74504 "TT-Programmes"
{

    fields
    {
        field(1; "Academic Year"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Semester; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Programme Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "ACA-Programme"."Code" where("Time Table" = filter(true));
            trigger OnValidate()
            var
                progs: Record "ACA-Programme";
            begin
                progs.Reset();
                progs.SetRange(code, "Programme Code");
                if progs.Find('-') then
                    "Prog. Name" := progs.Description;
            end;
        }
        field(4; "Prog. Name"; Text[200])
        {
            CalcFormula = Lookup("ACA-Programme".Description WHERE(Code = FIELD("Programme Code")));
            FieldClass = FlowField;
        }
        field(5; "Timetable Color"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'White,LightGray,WhiteSmoke,LightCoral,MistyRose,SeaShell,SandyBrown,PeachPuff,Peru,linen,Bisque,DarkOrange,Tan,Wheat,OldLace,FloralWhite,CornSilk,Gold,Moccasin,PapayaWhip,NavajoWhite,LemonChiffon,PaleGoldenrod,Biege,LightGoldenrodYellow,LightYellow,Ivory,GreenYellow,Chartreuse,Aqua,Cyan,LightCyan,Azure,LightBlue,AliceBlue,Thistle,Plum,Orchid,Pink,LightPink,Magenta,Fuchsia,Violet,DarkKhaki,Lime';
            OptionMembers = White,LightGray,WhiteSmoke,LightCoral,MistyRose,SeaShell,SandyBrown,PeachPuff,Peru,linen,Bisque,DarkOrange,Tan,Wheat,OldLace,FloralWhite,CornSilk,Gold,Moccasin,PapayaWhip,NavajoWhite,LemonChiffon,PaleGoldenrod,Biege,LightGoldenrodYellow,LightYellow,Ivory,GreenYellow,Chartreuse,Aqua,Cyan,LightCyan,Azure,LightBlue,AliceBlue,Thistle,Plum,Orchid,Pink,LightPink,Magenta,Fuchsia,Violet,DarkKhaki,"Lime";
        }
    }

    keys
    {
        key(Key1; "Academic Year", Semester, "Programme Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

