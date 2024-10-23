report 51794 "Fee Structure Summary Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Fee Structure Summary Report.rdl';

    dataset
    {
        dataitem(DataItem1; 61511)
        {
            RequestFilterFields = Code, "Settlement Type Filter";
            column(Pics; compInf.Picture)
            {
            }
            column(compInf_name2; compInf."Name 2")
            {

            }
            column(compInf_name; compInf.Name)
            {

            }
            column(compInf_email; compInf."E-Mail")
            {

            }
            column(compInf_phone1; compInf."Phone No.")
            {

            }
            column(compInf_phone2; compInf."Phone No. 2")
            {

            }
            column(Code; Code)
            {

            }
            column(ProgName; Description)
            {
            }
            column(FacultyName; Faculty)
            {
            }
            column(Y1; Y1)
            {
            }
            column(Y2; Y2)
            {
            }
            column(Y3; Y3)
            {
            }
            column(Y4; Y4)
            {
            }
            column(Y5; Y5)
            {
            }
            column(Y1_ItemLabel; Y1_ItemLabel)
            {
            }
            column(Y1S1_Tuit_Caption; Y1S1_Tuit_Caption)
            {
            }
            column(Y1S2_Tuit_Caption; Y1S2_Tuit_Caption)
            {
            }
            column(Y1_Tuit_Total_Caption; Y1_Tuit_Total_Caption)
            {
            }
            column(Y1S1_Tuit_Caption2; Y1S1_Tuit_Caption2)
            {
            }
            column(Y1S2_Tuit_Caption2; Y1S2_Tuit_Caption2)
            {
            }
            column(Y1_Tuit_Total_Caption2; Y1_Tuit_Total_Caption2)
            {
            }
            column(Y1S1_Tuit_Caption3; Y1S1_Tuit_Caption3)
            {
            }
            column(Y1S2_Tuit_Caption3; Y1S2_Tuit_Caption3)
            {
            }
            column(Y1_Tuit_Total_Caption3; Y1_Tuit_Total_Caption3)
            {
            }
            column(Y1S1_Tuit_Val; Y1S1_Tuit_Val)
            {
            }
            column(Y1S2_Tuit_Val; Y1S2_Tuit_Val)
            {
            }
            column(Y1_Tuit_Total_Val; Y1_Tuit_Total_Val)
            {
            }
            column(Y1_Tuit_txt_lbl1; Y1_Tuit_txt_lbl1)
            {
            }
            column(Y1_Charges_txt_lbl2; Y1_Charges_txt_lbl2)
            {
            }
            column(Y1_Tuit_txt; Y1_Tuit_txt)
            {
            }
            column(Y1_Tuit_txt2; Y1_Tuit_txt2)
            {
            }
            column(Y1_Charges_txt; Y1_Charges_txt)
            {
            }
            column(Y1_Charges_txt2; Y1_Charges_txt2)
            {
            }
            column(Y1_Trans_txt_Footer; Y1_Trans_txt_Footer)
            {
            }
            column(Y1S1_Total; Y1S1_Total)
            {
            }
            column(Y1S2_Total; Y1S2_Total)
            {
            }
            column(Y1_Grand_Total; Y1_Grand_Total)
            {
            }
            column(Y1_Trans_Txt1; Y1_Trans_Txt[1])
            {
            }
            column(Y1S1_Trans_Val1; Y1S1_Trans_Val[1])
            {
            }
            column(Y1S2_Trans_Val1; Y1S2_Trans_Val[1])
            {
            }
            column(Y1_Trans_Grand_Total1; Y1_Trans_Grand_Total[1])
            {
            }
            column(Y1_Trans_Code1; Y1_Trans_Code[1])
            {
            }
            column(Y1_Trans_Txt2; Y1_Trans_Txt[2])
            {
            }
            column(Y1S1_Trans_Val2; Y1S1_Trans_Val[2])
            {
            }
            column(Y1S2_Trans_Val2; Y1S2_Trans_Val[2])
            {
            }
            column(Y1_Trans_Grand_Total2; Y1_Trans_Grand_Total[2])
            {
            }
            column(Y1_Trans_Code2; Y1_Trans_Code[2])
            {
            }
            column(Y1_Trans_Txt3; Y1_Trans_Txt[3])
            {
            }
            column(Y1S1_Trans_Val3; Y1S1_Trans_Val[3])
            {
            }
            column(Y1S2_Trans_Val3; Y1S2_Trans_Val[3])
            {
            }
            column(Y1_Trans_Grand_Total3; Y1_Trans_Grand_Total[3])
            {
            }
            column(Y1_Trans_Code3; Y1_Trans_Code[3])
            {
            }
            column(Y1_Trans_Txt4; Y1_Trans_Txt[4])
            {
            }
            column(Y1S1_Trans_Val4; Y1S1_Trans_Val[4])
            {
            }
            column(Y1S2_Trans_Val4; Y1S2_Trans_Val[4])
            {
            }
            column(Y1_Trans_Grand_Total4; Y1_Trans_Grand_Total[4])
            {
            }
            column(Y1_Trans_Code4; Y1_Trans_Code[4])
            {
            }
            column(Y1_Trans_Txt5; Y1_Trans_Txt[5])
            {
            }
            column(Y1S1_Trans_Val5; Y1S1_Trans_Val[5])
            {
            }
            column(Y1S2_Trans_Val5; Y1S2_Trans_Val[5])
            {
            }
            column(Y1_Trans_Grand_Total5; Y1_Trans_Grand_Total[5])
            {
            }
            column(Y1_Trans_Code5; Y1_Trans_Code[5])
            {
            }
            column(Y1_Trans_Txt6; Y1_Trans_Txt[6])
            {
            }
            column(Y1S1_Trans_Val6; Y1S1_Trans_Val[6])
            {
            }
            column(Y1S2_Trans_Val6; Y1S2_Trans_Val[6])
            {
            }
            column(Y1_Trans_Grand_Total6; Y1_Trans_Grand_Total[6])
            {
            }
            column(Y1_Trans_Code6; Y1_Trans_Code[6])
            {
            }
            column(Y1_Trans_Txt7; Y1_Trans_Txt[7])
            {
            }
            column(Y1S1_Trans_Val7; Y1S1_Trans_Val[7])
            {
            }
            column(Y1S2_Trans_Val7; Y1S2_Trans_Val[7])
            {
            }
            column(Y1_Trans_Grand_Total7; Y1_Trans_Grand_Total[7])
            {
            }
            column(Y1_Trans_Code7; Y1_Trans_Code[7])
            {
            }
            column(Y1_Trans_Txt8; Y1_Trans_Txt[8])
            {
            }
            column(Y1S1_Trans_Val8; Y1S1_Trans_Val[8])
            {
            }
            column(Y1S2_Trans_Val8; Y1S2_Trans_Val[8])
            {
            }
            column(Y1_Trans_Grand_Total8; Y1_Trans_Grand_Total[8])
            {
            }
            column(Y1_Trans_Code8; Y1_Trans_Code[8])
            {
            }
            column(Y1_Trans_Txt9; Y1_Trans_Txt[9])
            {
            }
            column(Y1S1_Trans_Val9; Y1S1_Trans_Val[9])
            {
            }
            column(Y1S2_Trans_Val9; Y1S2_Trans_Val[9])
            {
            }
            column(Y1_Trans_Grand_Total9; Y1_Trans_Grand_Total[9])
            {
            }
            column(Y1_Trans_Code9; Y1_Trans_Code[9])
            {
            }
            column(Y1_Trans_Txt10; Y1_Trans_Txt[10])
            {
            }
            column(Y1S1_Trans_Val10; Y1S1_Trans_Val[10])
            {
            }
            column(Y1S2_Trans_Val10; Y1S2_Trans_Val[10])
            {
            }
            column(Y1_Trans_Grand_Total10; Y1_Trans_Grand_Total[10])
            {
            }
            column(Y1_Trans_Code10; Y1_Trans_Code[10])
            {
            }
            column(Y1_Trans_Txt11; Y1_Trans_Txt[11])
            {
            }
            column(Y1S1_Trans_Val11; Y1S1_Trans_Val[11])
            {
            }
            column(Y1S2_Trans_Val11; Y1S2_Trans_Val[11])
            {
            }
            column(Y1_Trans_Grand_Total11; Y1_Trans_Grand_Total[11])
            {
            }
            column(Y1_Trans_Code11; Y1_Trans_Code[11])
            {
            }
            column(Y1_Trans_Txt12; Y1_Trans_Txt[12])
            {
            }
            column(Y1S1_Trans_Val12; Y1S1_Trans_Val[12])
            {
            }
            column(Y1S2_Trans_Val12; Y1S2_Trans_Val[12])
            {
            }
            column(Y1_Trans_Grand_Total12; Y1_Trans_Grand_Total[12])
            {
            }
            column(Y1_Trans_Code12; Y1_Trans_Code[12])
            {
            }
            column(Y1_Trans_Txt13; Y1_Trans_Txt[13])
            {
            }
            column(Y1S1_Trans_Val13; Y1S1_Trans_Val[13])
            {
            }
            column(Y1S2_Trans_Val13; Y1S2_Trans_Val[13])
            {
            }
            column(Y1_Trans_Grand_Total13; Y1_Trans_Grand_Total[13])
            {
            }
            column(Y1_Trans_Code13; Y1_Trans_Code[13])
            {
            }
            column(Y1_Trans_Txt14; Y1_Trans_Txt[14])
            {
            }
            column(Y1S1_Trans_Val14; Y1S1_Trans_Val[14])
            {
            }
            column(Y1S2_Trans_Val14; Y1S2_Trans_Val[14])
            {
            }
            column(Y1_Trans_Grand_Total14; Y1_Trans_Grand_Total[14])
            {
            }
            column(Y1_Trans_Code14; Y1_Trans_Code[14])
            {
            }
            column(Y1_Trans_Txt15; Y1_Trans_Txt[15])
            {
            }
            column(Y1S1_Trans_Val15; Y1S1_Trans_Val[15])
            {
            }
            column(Y1S2_Trans_Val15; Y1S2_Trans_Val[15])
            {
            }
            column(Y1_Trans_Grand_Total15; Y1_Trans_Grand_Total[15])
            {
            }
            column(Y1_Trans_Code15; Y1_Trans_Code[15])
            {
            }
            column(Y1_Trans_Txt16; Y1_Trans_Txt[16])
            {
            }
            column(Y1S1_Trans_Val16; Y1S1_Trans_Val[16])
            {
            }
            column(Y1S2_Trans_Val16; Y1S2_Trans_Val[16])
            {
            }
            column(Y1_Trans_Grand_Total16; Y1_Trans_Grand_Total[16])
            {
            }
            column(Y1_Trans_Code16; Y1_Trans_Code[16])
            {
            }
            column(counts; counts)
            {
            }
            column(Settlement_Type; Settlement_Type + ' FEE STRUCTURE')
            {
            }
            column(i1; i1)
            {
            }
            column(Y2_ItemLabel; Y2_ItemLabel)
            {
            }
            column(Y2S1_Tuit_Caption; Y2S1_Tuit_Caption)
            {
            }
            column(Y2S2_Tuit_Caption; Y2S2_Tuit_Caption)
            {
            }
            column(Y2_Tuit_Total_Caption; Y2_Tuit_Total_Caption)
            {
            }
            column(Y2S1_Tuit_Caption2; Y2S1_Tuit_Caption2)
            {
            }
            column(Y2S2_Tuit_Caption2; Y2S2_Tuit_Caption2)
            {
            }
            column(Y2_Tuit_Total_Caption2; Y2_Tuit_Total_Caption2)
            {
            }
            column(Y2S1_Tuit_Caption3; Y2S1_Tuit_Caption3)
            {
            }
            column(Y2S2_Tuit_Caption3; Y2S2_Tuit_Caption3)
            {
            }
            column(Y2_Tuit_Total_Caption3; Y2_Tuit_Total_Caption3)
            {
            }
            column(Y2S1_Tuit_Val; Y2S1_Tuit_Val)
            {
            }
            column(Y2S2_Tuit_Val; Y2S2_Tuit_Val)
            {
            }
            column(Y2_Tuit_Total_Val; Y2_Tuit_Total_Val)
            {
            }
            column(Y2_Tuit_txt_lbl1; Y2_Tuit_txt_lbl1)
            {
            }
            column(Y2_Charges_txt_lbl2; Y2_Charges_txt_lbl2)
            {
            }
            column(Y2_Tuit_txt; Y2_Tuit_txt)
            {
            }
            column(Y2_Tuit_txt2; Y2_Tuit_txt2)
            {
            }
            column(Y2_Charges_txt; Y2_Charges_txt)
            {
            }
            column(Y2_Charges_txt2; Y2_Charges_txt2)
            {
            }
            column(Y2_Trans_txt_Footer; Y2_Trans_txt_Footer)
            {
            }
            column(Y2S1_Total; Y2S1_Total)
            {
            }
            column(Y2S2_Total; Y2S2_Total)
            {
            }
            column(Y2_Grand_Total; Y2_Grand_Total)
            {
            }
            column(Y2_Trans_Txt1; Y2_Trans_Txt[1])
            {
            }
            column(Y2S1_Trans_Val1; Y2S1_Trans_Val[1])
            {
            }
            column(Y2S2_Trans_Val1; Y2S2_Trans_Val[1])
            {
            }
            column(Y2_Trans_Grand_Total1; Y2_Trans_Grand_Total[1])
            {
            }
            column(Y2_Trans_Code1; Y2_Trans_Code[1])
            {
            }
            column(Y2_Trans_Txt2; Y2_Trans_Txt[2])
            {
            }
            column(Y2S1_Trans_Val2; Y2S1_Trans_Val[2])
            {
            }
            column(Y2S2_Trans_Val2; Y2S2_Trans_Val[2])
            {
            }
            column(Y2_Trans_Grand_Total2; Y2_Trans_Grand_Total[2])
            {
            }
            column(Y2_Trans_Code2; Y2_Trans_Code[2])
            {
            }
            column(Y2_Trans_Txt3; Y2_Trans_Txt[3])
            {
            }
            column(Y2S1_Trans_Val3; Y2S1_Trans_Val[3])
            {
            }
            column(Y2S2_Trans_Val3; Y2S2_Trans_Val[3])
            {
            }
            column(Y2_Trans_Grand_Total3; Y2_Trans_Grand_Total[3])
            {
            }
            column(Y2_Trans_Code3; Y2_Trans_Code[3])
            {
            }
            column(Y2_Trans_Txt4; Y2_Trans_Txt[4])
            {
            }
            column(Y2S1_Trans_Val4; Y2S1_Trans_Val[4])
            {
            }
            column(Y2S2_Trans_Val4; Y2S2_Trans_Val[4])
            {
            }
            column(Y2_Trans_Grand_Total4; Y2_Trans_Grand_Total[4])
            {
            }
            column(Y2_Trans_Code4; Y2_Trans_Code[4])
            {
            }
            column(Y2_Trans_Txt5; Y2_Trans_Txt[5])
            {
            }
            column(Y2S1_Trans_Val5; Y2S1_Trans_Val[5])
            {
            }
            column(Y2S2_Trans_Val5; Y2S2_Trans_Val[5])
            {
            }
            column(Y2_Trans_Grand_Total5; Y2_Trans_Grand_Total[5])
            {
            }
            column(Y2_Trans_Code5; Y2_Trans_Code[5])
            {
            }
            column(Y2_Trans_Txt6; Y2_Trans_Txt[6])
            {
            }
            column(Y2S1_Trans_Val6; Y2S1_Trans_Val[6])
            {
            }
            column(Y2S2_Trans_Val6; Y2S2_Trans_Val[6])
            {
            }
            column(Y2_Trans_Grand_Total6; Y2_Trans_Grand_Total[6])
            {
            }
            column(Y2_Trans_Code6; Y2_Trans_Code[6])
            {
            }
            column(Y2_Trans_Txt7; Y2_Trans_Txt[7])
            {
            }
            column(Y2S1_Trans_Val7; Y2S1_Trans_Val[7])
            {
            }
            column(Y2S2_Trans_Val7; Y2S2_Trans_Val[7])
            {
            }
            column(Y2_Trans_Grand_Total7; Y2_Trans_Grand_Total[7])
            {
            }
            column(Y2_Trans_Code7; Y2_Trans_Code[7])
            {
            }
            column(Y2_Trans_Txt8; Y2_Trans_Txt[8])
            {
            }
            column(Y2S1_Trans_Val8; Y2S1_Trans_Val[8])
            {
            }
            column(Y2S2_Trans_Val8; Y2S2_Trans_Val[8])
            {
            }
            column(Y2_Trans_Grand_Total8; Y2_Trans_Grand_Total[8])
            {
            }
            column(Y2_Trans_Code8; Y2_Trans_Code[8])
            {
            }
            column(Y2_Trans_Txt9; Y2_Trans_Txt[9])
            {
            }
            column(Y2S1_Trans_Val9; Y2S1_Trans_Val[9])
            {
            }
            column(Y2S2_Trans_Val9; Y2S2_Trans_Val[9])
            {
            }
            column(Y2_Trans_Grand_Total9; Y2_Trans_Grand_Total[9])
            {
            }
            column(Y2_Trans_Code9; Y2_Trans_Code[9])
            {
            }
            column(Y2_Trans_Txt10; Y2_Trans_Txt[10])
            {
            }
            column(Y2S1_Trans_Val10; Y2S1_Trans_Val[10])
            {
            }
            column(Y2S2_Trans_Val10; Y2S2_Trans_Val[10])
            {
            }
            column(Y2_Trans_Grand_Total10; Y2_Trans_Grand_Total[10])
            {
            }
            column(Y2_Trans_Code10; Y2_Trans_Code[10])
            {
            }
            column(Y2_Trans_Txt11; Y2_Trans_Txt[11])
            {
            }
            column(Y2S1_Trans_Val11; Y2S1_Trans_Val[11])
            {
            }
            column(Y2S2_Trans_Val11; Y2S2_Trans_Val[11])
            {
            }
            column(Y2_Trans_Grand_Total11; Y2_Trans_Grand_Total[11])
            {
            }
            column(Y2_Trans_Code11; Y2_Trans_Code[11])
            {
            }
            column(Y2_Trans_Txt12; Y2_Trans_Txt[12])
            {
            }
            column(Y2S1_Trans_Val12; Y2S1_Trans_Val[12])
            {
            }
            column(Y2S2_Trans_Val12; Y2S2_Trans_Val[12])
            {
            }
            column(Y2_Trans_Grand_Total12; Y2_Trans_Grand_Total[12])
            {
            }
            column(Y2_Trans_Code12; Y2_Trans_Code[12])
            {
            }
            column(Y2_Trans_Txt13; Y2_Trans_Txt[13])
            {
            }
            column(Y2S1_Trans_Val13; Y2S1_Trans_Val[13])
            {
            }
            column(Y2S2_Trans_Val13; Y2S2_Trans_Val[13])
            {
            }
            column(Y2_Trans_Grand_Total13; Y2_Trans_Grand_Total[13])
            {
            }
            column(Y2_Trans_Code13; Y2_Trans_Code[13])
            {
            }
            column(Y2_Trans_Txt14; Y2_Trans_Txt[14])
            {
            }
            column(Y2S1_Trans_Val14; Y2S1_Trans_Val[14])
            {
            }
            column(Y2S2_Trans_Val14; Y2S2_Trans_Val[14])
            {
            }
            column(Y2_Trans_Grand_Total14; Y2_Trans_Grand_Total[14])
            {
            }
            column(Y2_Trans_Code14; Y2_Trans_Code[14])
            {
            }
            column(Y2_Trans_Txt15; Y2_Trans_Txt[15])
            {
            }
            column(Y2S1_Trans_Val15; Y2S1_Trans_Val[15])
            {
            }
            column(Y2S2_Trans_Val15; Y2S2_Trans_Val[15])
            {
            }
            column(Y2_Trans_Grand_Total15; Y2_Trans_Grand_Total[15])
            {
            }
            column(Y2_Trans_Code15; Y2_Trans_Code[15])
            {
            }
            column(Y2_Trans_Txt16; Y2_Trans_Txt[16])
            {
            }
            column(Y2S1_Trans_Val16; Y2S1_Trans_Val[16])
            {
            }
            column(Y2S2_Trans_Val16; Y2S2_Trans_Val[16])
            {
            }
            column(Y2_Trans_Grand_Total16; Y2_Trans_Grand_Total[16])
            {
            }
            column(Y2_Trans_Code16; Y2_Trans_Code[16])
            {
            }
            column(i2; i2)
            {
            }
            column(Y3_ItemLabel; Y3_ItemLabel)
            {
            }
            column(Y3S1_Tuit_Caption; Y3S1_Tuit_Caption)
            {
            }
            column(Y3S2_Tuit_Caption; Y3S2_Tuit_Caption)
            {
            }
            column(Y3_Tuit_Total_Caption; Y3_Tuit_Total_Caption)
            {
            }
            column(Y3S1_Tuit_Caption2; Y3S1_Tuit_Caption2)
            {
            }
            column(Y3S2_Tuit_Caption2; Y3S2_Tuit_Caption2)
            {
            }
            column(Y3_Tuit_Total_Caption2; Y3_Tuit_Total_Caption2)
            {
            }
            column(Y3S1_Tuit_Caption3; Y3S1_Tuit_Caption3)
            {
            }
            column(Y3S2_Tuit_Caption3; Y3S2_Tuit_Caption3)
            {
            }
            column(Y3_Tuit_Total_Caption3; Y3_Tuit_Total_Caption3)
            {
            }
            column(Y3S1_Tuit_Val; Y3S1_Tuit_Val)
            {
            }
            column(Y3S2_Tuit_Val; Y3S2_Tuit_Val)
            {
            }
            column(Y3_Tuit_Total_Val; Y3_Tuit_Total_Val)
            {
            }
            column(Y3_Tuit_txt_lbl1; Y3_Tuit_txt_lbl1)
            {
            }
            column(Y3_Charges_txt_lbl2; Y3_Charges_txt_lbl2)
            {
            }
            column(Y3_Tuit_txt; Y3_Tuit_txt)
            {
            }
            column(Y3_Tuit_txt2; Y3_Tuit_txt2)
            {
            }
            column(Y3_Charges_txt; Y3_Charges_txt)
            {
            }
            column(Y3_Charges_txt2; Y3_Charges_txt2)
            {
            }
            column(Y3_Trans_txt_Footer; Y3_Trans_txt_Footer)
            {
            }
            column(Y3S1_Total; Y3S1_Total)
            {
            }
            column(Y3S2_Total; Y3S2_Total)
            {
            }
            column(Y3_Grand_Total; Y3_Grand_Total)
            {
            }
            column(Y3_Trans_Txt1; Y3_Trans_Txt[1])
            {
            }
            column(Y3S1_Trans_Val1; Y3S1_Trans_Val[1])
            {
            }
            column(Y3S2_Trans_Val1; Y3S2_Trans_Val[1])
            {
            }
            column(Y3_Trans_Grand_Total1; Y3_Trans_Grand_Total[1])
            {
            }
            column(Y3_Trans_Code1; Y3_Trans_Code[1])
            {
            }
            column(Y3_Trans_Txt2; Y3_Trans_Txt[2])
            {
            }
            column(Y3S1_Trans_Val2; Y3S1_Trans_Val[2])
            {
            }
            column(Y3S2_Trans_Val2; Y3S2_Trans_Val[2])
            {
            }
            column(Y3_Trans_Grand_Total2; Y3_Trans_Grand_Total[2])
            {
            }
            column(Y3_Trans_Code2; Y3_Trans_Code[2])
            {
            }
            column(Y3_Trans_Txt3; Y3_Trans_Txt[3])
            {
            }
            column(Y3S1_Trans_Val3; Y3S1_Trans_Val[3])
            {
            }
            column(Y3S2_Trans_Val3; Y3S2_Trans_Val[3])
            {
            }
            column(Y3_Trans_Grand_Total3; Y3_Trans_Grand_Total[3])
            {
            }
            column(Y3_Trans_Code3; Y3_Trans_Code[3])
            {
            }
            column(Y3_Trans_Txt4; Y3_Trans_Txt[4])
            {
            }
            column(Y3S1_Trans_Val4; Y3S1_Trans_Val[4])
            {
            }
            column(Y3S2_Trans_Val4; Y3S2_Trans_Val[4])
            {
            }
            column(Y3_Trans_Grand_Total4; Y3_Trans_Grand_Total[4])
            {
            }
            column(Y3_Trans_Code4; Y3_Trans_Code[4])
            {
            }
            column(Y3_Trans_Txt5; Y3_Trans_Txt[5])
            {
            }
            column(Y3S1_Trans_Val5; Y3S1_Trans_Val[5])
            {
            }
            column(Y3S2_Trans_Val5; Y3S2_Trans_Val[5])
            {
            }
            column(Y3_Trans_Grand_Total5; Y3_Trans_Grand_Total[5])
            {
            }
            column(Y3_Trans_Code5; Y3_Trans_Code[5])
            {
            }
            column(Y3_Trans_Txt6; Y3_Trans_Txt[6])
            {
            }
            column(Y3S1_Trans_Val6; Y3S1_Trans_Val[6])
            {
            }
            column(Y3S2_Trans_Val6; Y3S2_Trans_Val[6])
            {
            }
            column(Y3_Trans_Grand_Total6; Y3_Trans_Grand_Total[6])
            {
            }
            column(Y3_Trans_Code6; Y3_Trans_Code[6])
            {
            }
            column(Y3_Trans_Txt7; Y3_Trans_Txt[7])
            {
            }
            column(Y3S1_Trans_Val7; Y3S1_Trans_Val[7])
            {
            }
            column(Y3S2_Trans_Val7; Y3S2_Trans_Val[7])
            {
            }
            column(Y3_Trans_Grand_Total7; Y3_Trans_Grand_Total[7])
            {
            }
            column(Y3_Trans_Code7; Y3_Trans_Code[7])
            {
            }
            column(Y3_Trans_Txt8; Y3_Trans_Txt[8])
            {
            }
            column(Y3S1_Trans_Val8; Y3S1_Trans_Val[8])
            {
            }
            column(Y3S2_Trans_Val8; Y3S2_Trans_Val[8])
            {
            }
            column(Y3_Trans_Grand_Total8; Y3_Trans_Grand_Total[8])
            {
            }
            column(Y3_Trans_Code8; Y3_Trans_Code[8])
            {
            }
            column(Y3_Trans_Txt9; Y3_Trans_Txt[9])
            {
            }
            column(Y3S1_Trans_Val9; Y3S1_Trans_Val[9])
            {
            }
            column(Y3S2_Trans_Val9; Y3S2_Trans_Val[9])
            {
            }
            column(Y3_Trans_Grand_Total9; Y3_Trans_Grand_Total[9])
            {
            }
            column(Y3_Trans_Code9; Y3_Trans_Code[9])
            {
            }
            column(Y3_Trans_Txt10; Y3_Trans_Txt[10])
            {
            }
            column(Y3S1_Trans_Val10; Y3S1_Trans_Val[10])
            {
            }
            column(Y3S2_Trans_Val10; Y3S2_Trans_Val[10])
            {
            }
            column(Y3_Trans_Grand_Total10; Y3_Trans_Grand_Total[10])
            {
            }
            column(Y3_Trans_Code10; Y3_Trans_Code[10])
            {
            }
            column(Y3_Trans_Txt11; Y3_Trans_Txt[11])
            {
            }
            column(Y3S1_Trans_Val11; Y3S1_Trans_Val[11])
            {
            }
            column(Y3S2_Trans_Val11; Y3S2_Trans_Val[11])
            {
            }
            column(Y3_Trans_Grand_Total11; Y3_Trans_Grand_Total[11])
            {
            }
            column(Y3_Trans_Code11; Y3_Trans_Code[11])
            {
            }
            column(Y3_Trans_Txt12; Y3_Trans_Txt[12])
            {
            }
            column(Y3S1_Trans_Val12; Y3S1_Trans_Val[12])
            {
            }
            column(Y3S2_Trans_Val12; Y3S2_Trans_Val[12])
            {
            }
            column(Y3_Trans_Grand_Total12; Y3_Trans_Grand_Total[12])
            {
            }
            column(Y3_Trans_Code12; Y3_Trans_Code[12])
            {
            }
            column(Y3_Trans_Txt13; Y3_Trans_Txt[13])
            {
            }
            column(Y3S1_Trans_Val13; Y3S1_Trans_Val[13])
            {
            }
            column(Y3S2_Trans_Val13; Y3S2_Trans_Val[13])
            {
            }
            column(Y3_Trans_Grand_Total13; Y3_Trans_Grand_Total[13])
            {
            }
            column(Y3_Trans_Code13; Y3_Trans_Code[13])
            {
            }
            column(Y3_Trans_Txt14; Y3_Trans_Txt[14])
            {
            }
            column(Y3S1_Trans_Val14; Y3S1_Trans_Val[14])
            {
            }
            column(Y3S2_Trans_Val14; Y3S2_Trans_Val[14])
            {
            }
            column(Y3_Trans_Grand_Total14; Y3_Trans_Grand_Total[14])
            {
            }
            column(Y3_Trans_Code14; Y3_Trans_Code[14])
            {
            }
            column(Y3_Trans_Txt15; Y3_Trans_Txt[15])
            {
            }
            column(Y3S1_Trans_Val15; Y3S1_Trans_Val[15])
            {
            }
            column(Y3S2_Trans_Val15; Y3S2_Trans_Val[15])
            {
            }
            column(Y3_Trans_Grand_Total15; Y3_Trans_Grand_Total[15])
            {
            }
            column(Y3_Trans_Code15; Y3_Trans_Code[15])
            {
            }
            column(Y3_Trans_Txt16; Y3_Trans_Txt[16])
            {
            }
            column(Y3S1_Trans_Val16; Y3S1_Trans_Val[16])
            {
            }
            column(Y3S2_Trans_Val16; Y3S2_Trans_Val[16])
            {
            }
            column(Y3_Trans_Grand_Total16; Y3_Trans_Grand_Total[16])
            {
            }
            column(Y3_Trans_Code16; Y3_Trans_Code[16])
            {
            }
            column(i3; i3)
            {
            }
            column(Y4_ItemLabel; Y4_ItemLabel)
            {
            }
            column(Y4S1_Tuit_Caption; Y4S1_Tuit_Caption)
            {
            }
            column(Y4S2_Tuit_Caption; Y4S2_Tuit_Caption)
            {
            }
            column(Y4_Tuit_Total_Caption; Y4_Tuit_Total_Caption)
            {
            }
            column(Y4S1_Tuit_Caption2; Y4S1_Tuit_Caption2)
            {
            }
            column(Y4S2_Tuit_Caption2; Y4S2_Tuit_Caption2)
            {
            }
            column(Y4_Tuit_Total_Caption2; Y4_Tuit_Total_Caption2)
            {
            }
            column(Y4S1_Tuit_Caption3; Y4S1_Tuit_Caption3)
            {
            }
            column(Y4S2_Tuit_Caption3; Y4S2_Tuit_Caption3)
            {
            }
            column(Y4_Tuit_Total_Caption3; Y4_Tuit_Total_Caption3)
            {
            }
            column(Y4S1_Tuit_Val; Y4S1_Tuit_Val)
            {
            }
            column(Y4S2_Tuit_Val; Y4S2_Tuit_Val)
            {
            }
            column(Y4_Tuit_Total_Val; Y4_Tuit_Total_Val)
            {
            }
            column(Y4_Tuit_txt_lbl1; Y4_Tuit_txt_lbl1)
            {
            }
            column(Y4_Charges_txt_lbl2; Y4_Charges_txt_lbl2)
            {
            }
            column(Y4_Tuit_txt; Y4_Tuit_txt)
            {
            }
            column(Y4_Tuit_txt2; Y4_Tuit_txt2)
            {
            }
            column(Y4_Charges_txt; Y4_Charges_txt)
            {
            }
            column(Y4_Charges_txt2; Y4_Charges_txt2)
            {
            }
            column(Y4_Trans_txt_Footer; Y4_Trans_txt_Footer)
            {
            }
            column(Y4S1_Total; Y4S1_Total)
            {
            }
            column(Y4S2_Total; Y4S2_Total)
            {
            }
            column(Y4_Grand_Total; Y4_Grand_Total)
            {
            }
            column(Y4_Trans_Txt1; Y4_Trans_Txt[1])
            {
            }
            column(Y4S1_Trans_Val1; Y4S1_Trans_Val[1])
            {
            }
            column(Y4S2_Trans_Val1; Y4S2_Trans_Val[1])
            {
            }
            column(Y4_Trans_Grand_Total1; Y4_Trans_Grand_Total[1])
            {
            }
            column(Y4_Trans_Code1; Y4_Trans_Code[1])
            {
            }
            column(Y4_Trans_Txt2; Y4_Trans_Txt[2])
            {
            }
            column(Y4S1_Trans_Val2; Y4S1_Trans_Val[2])
            {
            }
            column(Y4S2_Trans_Val2; Y4S2_Trans_Val[2])
            {
            }
            column(Y4_Trans_Grand_Total2; Y4_Trans_Grand_Total[2])
            {
            }
            column(Y4_Trans_Code2; Y4_Trans_Code[2])
            {
            }
            column(Y4_Trans_Txt3; Y4_Trans_Txt[3])
            {
            }
            column(Y4S1_Trans_Val3; Y4S1_Trans_Val[3])
            {
            }
            column(Y4S2_Trans_Val3; Y4S2_Trans_Val[3])
            {
            }
            column(Y4_Trans_Grand_Total3; Y4_Trans_Grand_Total[3])
            {
            }
            column(Y4_Trans_Code3; Y4_Trans_Code[3])
            {
            }
            column(Y4_Trans_Txt4; Y4_Trans_Txt[4])
            {
            }
            column(Y4S1_Trans_Val4; Y4S1_Trans_Val[4])
            {
            }
            column(Y4S2_Trans_Val4; Y4S2_Trans_Val[4])
            {
            }
            column(Y4_Trans_Grand_Total4; Y4_Trans_Grand_Total[4])
            {
            }
            column(Y4_Trans_Code4; Y4_Trans_Code[4])
            {
            }
            column(Y4_Trans_Txt5; Y4_Trans_Txt[5])
            {
            }
            column(Y4S1_Trans_Val5; Y4S1_Trans_Val[5])
            {
            }
            column(Y4S2_Trans_Val5; Y4S2_Trans_Val[5])
            {
            }
            column(Y4_Trans_Grand_Total5; Y4_Trans_Grand_Total[5])
            {
            }
            column(Y4_Trans_Code5; Y4_Trans_Code[5])
            {
            }
            column(Y4_Trans_Txt6; Y4_Trans_Txt[6])
            {
            }
            column(Y4S1_Trans_Val6; Y4S1_Trans_Val[6])
            {
            }
            column(Y4S2_Trans_Val6; Y4S2_Trans_Val[6])
            {
            }
            column(Y4_Trans_Grand_Total6; Y4_Trans_Grand_Total[6])
            {
            }
            column(Y4_Trans_Code6; Y4_Trans_Code[6])
            {
            }
            column(Y4_Trans_Txt7; Y4_Trans_Txt[7])
            {
            }
            column(Y4S1_Trans_Val7; Y4S1_Trans_Val[7])
            {
            }
            column(Y4S2_Trans_Val7; Y4S2_Trans_Val[7])
            {
            }
            column(Y4_Trans_Grand_Total7; Y4_Trans_Grand_Total[7])
            {
            }
            column(Y4_Trans_Code7; Y4_Trans_Code[7])
            {
            }
            column(Y4_Trans_Txt8; Y4_Trans_Txt[8])
            {
            }
            column(Y4S1_Trans_Val8; Y4S1_Trans_Val[8])
            {
            }
            column(Y4S2_Trans_Val8; Y4S2_Trans_Val[8])
            {
            }
            column(Y4_Trans_Grand_Total8; Y4_Trans_Grand_Total[8])
            {
            }
            column(Y4_Trans_Code8; Y4_Trans_Code[8])
            {
            }
            column(Y4_Trans_Txt9; Y4_Trans_Txt[9])
            {
            }
            column(Y4S1_Trans_Val9; Y4S1_Trans_Val[9])
            {
            }
            column(Y4S2_Trans_Val9; Y4S2_Trans_Val[9])
            {
            }
            column(Y4_Trans_Grand_Total9; Y4_Trans_Grand_Total[9])
            {
            }
            column(Y4_Trans_Code9; Y4_Trans_Code[9])
            {
            }
            column(Y4_Trans_Txt10; Y4_Trans_Txt[10])
            {
            }
            column(Y4S1_Trans_Val10; Y4S1_Trans_Val[10])
            {
            }
            column(Y4S2_Trans_Val10; Y4S2_Trans_Val[10])
            {
            }
            column(Y4_Trans_Grand_Total10; Y4_Trans_Grand_Total[10])
            {
            }
            column(Y4_Trans_Code10; Y4_Trans_Code[10])
            {
            }
            column(Y4_Trans_Txt11; Y4_Trans_Txt[11])
            {
            }
            column(Y4S1_Trans_Val11; Y4S1_Trans_Val[11])
            {
            }
            column(Y4S2_Trans_Val11; Y4S2_Trans_Val[11])
            {
            }
            column(Y4_Trans_Grand_Total11; Y4_Trans_Grand_Total[11])
            {
            }
            column(Y4_Trans_Code11; Y4_Trans_Code[11])
            {
            }
            column(Y4_Trans_Txt12; Y4_Trans_Txt[12])
            {
            }
            column(Y4S1_Trans_Val12; Y4S1_Trans_Val[12])
            {
            }
            column(Y4S2_Trans_Val12; Y4S2_Trans_Val[12])
            {
            }
            column(Y4_Trans_Grand_Total12; Y4_Trans_Grand_Total[12])
            {
            }
            column(Y4_Trans_Code12; Y4_Trans_Code[12])
            {
            }
            column(Y4_Trans_Txt13; Y4_Trans_Txt[13])
            {
            }
            column(Y4S1_Trans_Val13; Y4S1_Trans_Val[13])
            {
            }
            column(Y4S2_Trans_Val13; Y4S2_Trans_Val[13])
            {
            }
            column(Y4_Trans_Grand_Total13; Y4_Trans_Grand_Total[13])
            {
            }
            column(Y4_Trans_Code13; Y4_Trans_Code[13])
            {
            }
            column(Y4_Trans_Txt14; Y4_Trans_Txt[14])
            {
            }
            column(Y4S1_Trans_Val14; Y4S1_Trans_Val[14])
            {
            }
            column(Y4S2_Trans_Val14; Y4S2_Trans_Val[14])
            {
            }
            column(Y4_Trans_Grand_Total14; Y4_Trans_Grand_Total[14])
            {
            }
            column(Y4_Trans_Code14; Y4_Trans_Code[14])
            {
            }
            column(Y4_Trans_Txt15; Y4_Trans_Txt[15])
            {
            }
            column(Y4S1_Trans_Val15; Y4S1_Trans_Val[15])
            {
            }
            column(Y4S2_Trans_Val15; Y4S2_Trans_Val[15])
            {
            }
            column(Y4_Trans_Grand_Total15; Y4_Trans_Grand_Total[15])
            {
            }
            column(Y4_Trans_Code15; Y4_Trans_Code[15])
            {
            }
            column(Y4_Trans_Txt16; Y4_Trans_Txt[16])
            {
            }
            column(Y4S1_Trans_Val16; Y4S1_Trans_Val[16])
            {
            }
            column(Y4S2_Trans_Val16; Y4S2_Trans_Val[16])
            {
            }
            column(Y4_Trans_Grand_Total16; Y4_Trans_Grand_Total[16])
            {
            }
            column(Y4_Trans_Code16; Y4_Trans_Code[16])
            {
            }
            column(i4; i4)
            {
            }
            column(Y5_ItemLabel; Y5_ItemLabel)
            {
            }
            column(Y5S1_Tuit_Caption; Y5S1_Tuit_Caption)
            {
            }
            column(Y5S2_Tuit_Caption; Y5S2_Tuit_Caption)
            {
            }
            column(Y5_Tuit_Total_Caption; Y5_Tuit_Total_Caption)
            {
            }
            column(Y5S1_Tuit_Caption2; Y5S1_Tuit_Caption2)
            {
            }
            column(Y5S2_Tuit_Caption2; Y5S2_Tuit_Caption2)
            {
            }
            column(Y5_Tuit_Total_Caption2; Y5_Tuit_Total_Caption2)
            {
            }
            column(Y5S1_Tuit_Caption3; Y5S1_Tuit_Caption3)
            {
            }
            column(Y5S2_Tuit_Caption3; Y5S2_Tuit_Caption3)
            {
            }
            column(Y5_Tuit_Total_Caption3; Y5_Tuit_Total_Caption3)
            {
            }
            column(Y5S1_Tuit_Val; Y5S1_Tuit_Val)
            {
            }
            column(Y5S2_Tuit_Val; Y5S2_Tuit_Val)
            {
            }
            column(Y5_Tuit_Total_Val; Y5_Tuit_Total_Val)
            {
            }
            column(Y5_Tuit_txt_lbl1; Y5_Tuit_txt_lbl1)
            {
            }
            column(Y5_Charges_txt_lbl2; Y5_Charges_txt_lbl2)
            {
            }
            column(Y5_Tuit_txt; Y5_Tuit_txt)
            {
            }
            column(Y5_Tuit_txt2; Y5_Tuit_txt2)
            {
            }
            column(Y5_Charges_txt; Y5_Charges_txt)
            {
            }
            column(Y5_Charges_txt2; Y5_Charges_txt2)
            {
            }
            column(Y5_Trans_txt_Footer; Y5_Trans_txt_Footer)
            {
            }
            column(Y5S1_Total; Y5S1_Total)
            {
            }
            column(Y5S2_Total; Y5S2_Total)
            {
            }
            column(Y5_Grand_Total; Y5_Grand_Total)
            {
            }
            column(Y5_Trans_Txt1; Y5_Trans_Txt[1])
            {
            }
            column(Y5S1_Trans_Val1; Y5S1_Trans_Val[1])
            {
            }
            column(Y5S2_Trans_Val1; Y5S2_Trans_Val[1])
            {
            }
            column(Y5_Trans_Grand_Total1; Y5_Trans_Grand_Total[1])
            {
            }
            column(Y5_Trans_Code1; Y5_Trans_Code[1])
            {
            }
            column(Y5_Trans_Txt2; Y5_Trans_Txt[2])
            {
            }
            column(Y5S1_Trans_Val2; Y5S1_Trans_Val[2])
            {
            }
            column(Y5S2_Trans_Val2; Y5S2_Trans_Val[2])
            {
            }
            column(Y5_Trans_Grand_Total2; Y5_Trans_Grand_Total[2])
            {
            }
            column(Y5_Trans_Code2; Y5_Trans_Code[2])
            {
            }
            column(Y5_Trans_Txt3; Y5_Trans_Txt[3])
            {
            }
            column(Y5S1_Trans_Val3; Y5S1_Trans_Val[3])
            {
            }
            column(Y5S2_Trans_Val3; Y5S2_Trans_Val[3])
            {
            }
            column(Y5_Trans_Grand_Total3; Y5_Trans_Grand_Total[3])
            {
            }
            column(Y5_Trans_Code3; Y5_Trans_Code[3])
            {
            }
            column(Y5_Trans_Txt4; Y5_Trans_Txt[4])
            {
            }
            column(Y5S1_Trans_Val4; Y5S1_Trans_Val[4])
            {
            }
            column(Y5S2_Trans_Val4; Y5S2_Trans_Val[4])
            {
            }
            column(Y5_Trans_Grand_Total4; Y5_Trans_Grand_Total[4])
            {
            }
            column(Y5_Trans_Code4; Y5_Trans_Code[4])
            {
            }
            column(Y5_Trans_Txt5; Y5_Trans_Txt[5])
            {
            }
            column(Y5S1_Trans_Val5; Y5S1_Trans_Val[5])
            {
            }
            column(Y5S2_Trans_Val5; Y5S2_Trans_Val[5])
            {
            }
            column(Y5_Trans_Grand_Total5; Y5_Trans_Grand_Total[5])
            {
            }
            column(Y5_Trans_Code5; Y5_Trans_Code[5])
            {
            }
            column(Y5_Trans_Txt6; Y5_Trans_Txt[6])
            {
            }
            column(Y5S1_Trans_Val6; Y5S1_Trans_Val[6])
            {
            }
            column(Y5S2_Trans_Val6; Y5S2_Trans_Val[6])
            {
            }
            column(Y5_Trans_Grand_Total6; Y5_Trans_Grand_Total[6])
            {
            }
            column(Y5_Trans_Code6; Y5_Trans_Code[6])
            {
            }
            column(Y5_Trans_Txt7; Y5_Trans_Txt[7])
            {
            }
            column(Y5S1_Trans_Val7; Y5S1_Trans_Val[7])
            {
            }
            column(Y5S2_Trans_Val7; Y5S2_Trans_Val[7])
            {
            }
            column(Y5_Trans_Grand_Total7; Y5_Trans_Grand_Total[7])
            {
            }
            column(Y5_Trans_Code7; Y5_Trans_Code[7])
            {
            }
            column(Y5_Trans_Txt8; Y5_Trans_Txt[8])
            {
            }
            column(Y5S1_Trans_Val8; Y5S1_Trans_Val[8])
            {
            }
            column(Y5S2_Trans_Val8; Y5S2_Trans_Val[8])
            {
            }
            column(Y5_Trans_Grand_Total8; Y5_Trans_Grand_Total[8])
            {
            }
            column(Y5_Trans_Code8; Y5_Trans_Code[8])
            {
            }
            column(Y5_Trans_Txt9; Y5_Trans_Txt[9])
            {
            }
            column(Y5S1_Trans_Val9; Y5S1_Trans_Val[9])
            {
            }
            column(Y5S2_Trans_Val9; Y5S2_Trans_Val[9])
            {
            }
            column(Y5_Trans_Grand_Total9; Y5_Trans_Grand_Total[9])
            {
            }
            column(Y5_Trans_Code9; Y5_Trans_Code[9])
            {
            }
            column(Y5_Trans_Txt10; Y5_Trans_Txt[10])
            {
            }
            column(Y5S1_Trans_Val10; Y5S1_Trans_Val[10])
            {
            }
            column(Y5S2_Trans_Val10; Y5S2_Trans_Val[10])
            {
            }
            column(Y5_Trans_Grand_Total10; Y5_Trans_Grand_Total[10])
            {
            }
            column(Y5_Trans_Code10; Y5_Trans_Code[10])
            {
            }
            column(Y5_Trans_Txt11; Y5_Trans_Txt[11])
            {
            }
            column(Y5S1_Trans_Val11; Y5S1_Trans_Val[11])
            {
            }
            column(Y5S2_Trans_Val11; Y5S2_Trans_Val[11])
            {
            }
            column(Y5_Trans_Grand_Total11; Y5_Trans_Grand_Total[11])
            {
            }
            column(Y5_Trans_Code11; Y5_Trans_Code[11])
            {
            }
            column(Y5_Trans_Txt12; Y5_Trans_Txt[12])
            {
            }
            column(Y5S1_Trans_Val12; Y5S1_Trans_Val[12])
            {
            }
            column(Y5S2_Trans_Val12; Y5S2_Trans_Val[12])
            {
            }
            column(Y5_Trans_Grand_Total12; Y5_Trans_Grand_Total[12])
            {
            }
            column(Y5_Trans_Code12; Y5_Trans_Code[12])
            {
            }
            column(Y5_Trans_Txt13; Y5_Trans_Txt[13])
            {
            }
            column(Y5S1_Trans_Val13; Y5S1_Trans_Val[13])
            {
            }
            column(Y5S2_Trans_Val13; Y5S2_Trans_Val[13])
            {
            }
            column(Y5_Trans_Grand_Total13; Y5_Trans_Grand_Total[13])
            {
            }
            column(Y5_Trans_Code13; Y5_Trans_Code[13])
            {
            }
            column(Y5_Trans_Txt14; Y5_Trans_Txt[14])
            {
            }
            column(Y5S1_Trans_Val14; Y5S1_Trans_Val[14])
            {
            }
            column(Y5S2_Trans_Val14; Y5S2_Trans_Val[14])
            {
            }
            column(Y5_Trans_Grand_Total14; Y5_Trans_Grand_Total[14])
            {
            }
            column(Y5_Trans_Code14; Y5_Trans_Code[14])
            {
            }
            column(Y5_Trans_Txt15; Y5_Trans_Txt[15])
            {
            }
            column(Y5S1_Trans_Val15; Y5S1_Trans_Val[15])
            {
            }
            column(Y5S2_Trans_Val15; Y5S2_Trans_Val[15])
            {
            }
            column(Y5_Trans_Grand_Total15; Y5_Trans_Grand_Total[15])
            {
            }
            column(Y5_Trans_Code15; Y5_Trans_Code[15])
            {
            }
            column(Y5_Trans_Txt16; Y5_Trans_Txt[16])
            {
            }
            column(Y5S1_Trans_Val16; Y5S1_Trans_Val[16])
            {
            }
            column(Y5S2_Trans_Val16; Y5S2_Trans_Val[16])
            {
            }
            column(Y5_Trans_Grand_Total16; Y5_Trans_Grand_Total[16])
            {
            }
            column(Y5_Trans_Code16; Y5_Trans_Code[16])
            {
            }
            column(i5; i5)
            {
            }

            trigger OnAfterGetRecord()
            begin
                // Initialize all Variables
                clearVariables1();
                clearVariables2();
                clearVariables3();
                clearVariables4();
                clearVariables5();
                progStages.RESET;
                progStages.SETRANGE(progStages."Programme Code", Code);
                IF progStages.FIND('-') THEN BEGIN
                    REPEAT
                    BEGIN
                        IF (COPYSTR(progStages.Code, 1, 2) = 'Y1') THEN BEGIN // Check if the stage is for First Years
                            IF Y1 = '' THEN Y1 := 'ACADEMIC YEAR - 1ST YEAR STUDENTS';
                            Y1_ItemLabel := 'ITEM';
                            Y1S1_Tuit_Caption := 'FIRST';
                            Y1S2_Tuit_Caption := 'SEMESTER';
                            Y1_Tuit_Total_Caption := '(KES)';
                            Y1S1_Tuit_Caption2 := 'SECOND';
                            Y1S2_Tuit_Caption2 := 'SEMESTER';
                            Y1_Tuit_Total_Caption2 := '(KES)';
                            Y1S1_Tuit_Caption3 := 'TOTAL PER';
                            Y1S2_Tuit_Caption3 := 'YEAR';
                            Y1_Tuit_Total_Caption3 := '(KES)';
                            Y1_Tuit_txt_lbl1 := 'A. TUITION: ';
                            Y1_Charges_txt_lbl2 := 'B. OTHER CHARGES: ';
                            Y1_Tuit_txt := 'to be paid to the University';
                            Y1_Tuit_txt2 := 'on the registration day';
                            Y1_Charges_txt := 'To bepaid to the ';
                            Y1_Charges_txt2 := 'University on the registration day';
                            Y1_Trans_txt_Footer := 'TOTAL FEE PAYABLE TO CUEA';
                            /// Fetch Charges and populate here
                            //********************************************Y1**************************************************//
                            // Fetch Charges per Stage for 1st Year 1st Sem Here
                            IF progStages.Code = 'Y1S1' THEN BEGIN //4
                                stage_Charge.RESET;
                                stage_Charge.SETRANGE(stage_Charge."Programme Code", Code);
                                stage_Charge.SETRANGE(stage_Charge."Settlement Type", Settlement_Type);
                                stage_Charge.SETFILTER(stage_Charge."Stage Code", 'Y1S1');
                                IF stage_Charge.FIND('-') THEN BEGIN //3
                                    REPEAT
                                    BEGIN // Begin for Y1S1 Charges Loop 1
                                          // Charges for Y1S1 Exists
                                          //Fetch Name for the charge
                                        IF charges.GET(stage_Charge.Code) THEN
                                            IF NOT ((charges.Description) IN [Y1_Trans_Txt[1] .. Y1_Trans_Txt[13]]) THEN BEGIN // Charge Item Has not been Fetched already //2
                                                                                                                               //
                                                i1 := COMPRESSARRAY(Y1_Trans_Txt) + 1;
                                                Y1_Trans_Code[i1] := stage_Charge.Code;
                                                Y1_Trans_Txt[i1] := charges.Description;
                                                Y1S1_Trans_Val[i1] := stage_Charge.Amount;
                                                Y1_Trans_Grand_Total[i1] := Y1_Trans_Grand_Total[i1] + Y1S1_Trans_Val[i1];
                                                Y1S1_Total := Y1S1_Total + Y1S1_Trans_Val[i1];
                                                Y1_Grand_Total := Y1_Grand_Total + Y1S1_Trans_Val[i1];
                                            END; //2
                                    END; // end for Y1S1 Charges Loop (Repeat)1
                                    UNTIL stage_Charge.NEXT = 0;
                                END;//3
                                    // Fetch Tuition Fees for Y1S1
                                FeeByStage.RESET;
                                FeeByStage.SETRANGE(FeeByStage."Programme Code", Code);
                                FeeByStage.SETRANGE(FeeByStage."Stage Code", 'Y1S1');
                                FeeByStage.SETRANGE(FeeByStage."Settlemet Type", Settlement_Type);
                                IF FeeByStage.FIND('-') THEN BEGIN //6
                                    Y1S1_Tuit_Val := FeeByStage."Break Down";
                                    Y1_Tuit_Total_Val := Y1_Tuit_Total_Val + Y1S1_Tuit_Val;
                                    Y1S1_Total := Y1S1_Total + Y1S1_Tuit_Val;
                                    Y1_Grand_Total := Y1_Grand_Total + Y1S1_Tuit_Val;
                                END; // 6
                            END ELSE
                                IF progStages.Code = 'Y1S2' THEN BEGIN // 4/5
                                    CLEAR(counts);
                                    BEGIN // 7
                                        counts := counts + 1;
                                        // Fetch Charges per Stage for 1st Year 2nd sem Here
                                        stage_Charge.RESET;
                                        stage_Charge.SETRANGE(stage_Charge."Programme Code", Code);
                                        stage_Charge.SETRANGE(stage_Charge."Settlement Type", Settlement_Type);
                                        //stage_Charge.setrange(stage_Charge.Code,Y1_Trans_Code[counts]);
                                        stage_Charge.SETFILTER(stage_Charge."Stage Code", 'Y1S2');
                                        IF stage_Charge.FIND('-') THEN BEGIN //3
                                            REPEAT
                                            BEGIN // Begin for Y1S2 Charges Loop 1
                                                  // Charges for Y1S2 Exists
                                                  //Fetch Name for the charge
                                                  //ERROR(Y1_Trans_Txt[1]+': '+Y1_Trans_Txt[2]);
                                                IF charges.GET(stage_Charge.Code) THEN
                                                    //IF NOT ((charges.Description) IN [Y1_Trans_Txt[1]..Y1_Trans_Txt[13]]) THEN BEGIN // Charge Item Has not been Fetched already //2
                                                    IF NOT (((charges.Description = Y1_Trans_Txt[1]) OR (charges.Description = Y1_Trans_Txt[2])
                                OR (charges.Description = Y1_Trans_Txt[3]) OR (charges.Description = Y1_Trans_Txt[4])
                                OR (charges.Description = Y1_Trans_Txt[5]) OR (charges.Description = Y1_Trans_Txt[6])
                                OR (charges.Description = Y1_Trans_Txt[7]) OR (charges.Description = Y1_Trans_Txt[8])
                                OR (charges.Description = Y1_Trans_Txt[9]) OR (charges.Description = Y1_Trans_Txt[10])
                                OR (charges.Description = Y1_Trans_Txt[11]) OR (charges.Description = Y1_Trans_Txt[12])
                                OR (charges.Description = Y1_Trans_Txt[13]))) THEN BEGIN // Charge Item Has not been Fetched already //2
                                                                                         //
                                                        i1 := (COMPRESSARRAY(Y1_Trans_Txt)) + 1;
                                                        Y1_Trans_Code[i1] := stage_Charge.Code;
                                                        Y1_Trans_Txt[i1] := charges.Description;
                                                        Y1S2_Trans_Val[i1] := stage_Charge.Amount;
                                                        Y1_Trans_Grand_Total[i1] := Y1_Trans_Grand_Total[i1] + Y1S2_Trans_Val[i1];
                                                        Y1S2_Total := Y1S2_Total + Y1S2_Trans_Val[i1];
                                                        Y1_Grand_Total := Y1_Grand_Total + Y1S2_Trans_Val[i1];
                                                    END  //2
                                                    ELSE BEGIN//10 If the Item has notyet been picked
                                                        IF charges.Description = Y1_Trans_Txt[1] THEN BEGIN
                                                            Y1_Trans_Code[1] := stage_Charge.Code;
                                                            Y1_Trans_Txt[1] := charges.Description;
                                                            Y1S2_Trans_Val[1] := stage_Charge.Amount;
                                                            Y1_Trans_Grand_Total[1] := Y1_Trans_Grand_Total[1] + Y1S2_Trans_Val[1];
                                                            Y1S2_Total := Y1S2_Total + Y1S2_Trans_Val[1];
                                                            Y1_Grand_Total := Y1_Grand_Total + Y1S2_Trans_Val[1];
                                                        END ELSE
                                                            IF charges.Description = Y1_Trans_Txt[2] THEN BEGIN
                                                                Y1_Trans_Code[2] := stage_Charge.Code;
                                                                Y1_Trans_Txt[2] := charges.Description;
                                                                Y1S2_Trans_Val[2] := stage_Charge.Amount;
                                                                Y1_Trans_Grand_Total[2] := Y1_Trans_Grand_Total[2] + Y1S2_Trans_Val[2];
                                                                Y1S2_Total := Y1S2_Total + Y1S2_Trans_Val[2];
                                                                Y1_Grand_Total := Y1_Grand_Total + Y1S2_Trans_Val[2];
                                                            END ELSE
                                                                IF charges.Description = Y1_Trans_Txt[3] THEN BEGIN
                                                                    Y1_Trans_Code[3] := stage_Charge.Code;
                                                                    Y1_Trans_Txt[3] := charges.Description;
                                                                    Y1S2_Trans_Val[3] := stage_Charge.Amount;
                                                                    Y1_Trans_Grand_Total[3] := Y1_Trans_Grand_Total[3] + Y1S2_Trans_Val[3];
                                                                    Y1S2_Total := Y1S2_Total + Y1S2_Trans_Val[3];
                                                                    Y1_Grand_Total := Y1_Grand_Total + Y1S2_Trans_Val[3];

                                                                END ELSE
                                                                    IF charges.Description = Y1_Trans_Txt[4] THEN BEGIN
                                                                        Y1_Trans_Code[4] := stage_Charge.Code;
                                                                        Y1_Trans_Txt[4] := charges.Description;
                                                                        Y1S2_Trans_Val[4] := stage_Charge.Amount;
                                                                        Y1_Trans_Grand_Total[4] := Y1_Trans_Grand_Total[4] + Y1S2_Trans_Val[4];
                                                                        Y1S2_Total := Y1S2_Total + Y1S2_Trans_Val[4];
                                                                        Y1_Grand_Total := Y1_Grand_Total + Y1S2_Trans_Val[4];

                                                                    END ELSE
                                                                        IF charges.Description = Y1_Trans_Txt[5] THEN BEGIN
                                                                            Y1_Trans_Code[5] := stage_Charge.Code;
                                                                            Y1_Trans_Txt[5] := charges.Description;
                                                                            Y1S2_Trans_Val[5] := stage_Charge.Amount;
                                                                            Y1_Trans_Grand_Total[5] := Y1_Trans_Grand_Total[5] + Y1S2_Trans_Val[5];
                                                                            Y1S2_Total := Y1S2_Total + Y1S2_Trans_Val[5];
                                                                            Y1_Grand_Total := Y1_Grand_Total + Y1S2_Trans_Val[5];

                                                                        END ELSE
                                                                            IF charges.Description = Y1_Trans_Txt[6] THEN BEGIN
                                                                                Y1_Trans_Code[6] := stage_Charge.Code;
                                                                                Y1_Trans_Txt[6] := charges.Description;
                                                                                Y1S2_Trans_Val[6] := stage_Charge.Amount;
                                                                                Y1_Trans_Grand_Total[6] := Y1_Trans_Grand_Total[6] + Y1S2_Trans_Val[6];
                                                                                Y1S2_Total := Y1S2_Total + Y1S2_Trans_Val[6];
                                                                                Y1_Grand_Total := Y1_Grand_Total + Y1S2_Trans_Val[6];

                                                                            END ELSE
                                                                                IF charges.Description = Y1_Trans_Txt[7] THEN BEGIN
                                                                                    Y1_Trans_Code[7] := stage_Charge.Code;
                                                                                    Y1_Trans_Txt[7] := charges.Description;
                                                                                    Y1S2_Trans_Val[7] := stage_Charge.Amount;
                                                                                    Y1_Trans_Grand_Total[7] := Y1_Trans_Grand_Total[7] + Y1S2_Trans_Val[7];
                                                                                    Y1S2_Total := Y1S2_Total + Y1S2_Trans_Val[7];
                                                                                    Y1_Grand_Total := Y1_Grand_Total + Y1S2_Trans_Val[7];

                                                                                END ELSE
                                                                                    IF charges.Description = Y1_Trans_Txt[8] THEN BEGIN
                                                                                        Y1_Trans_Code[8] := stage_Charge.Code;
                                                                                        Y1_Trans_Txt[8] := charges.Description;
                                                                                        Y1S2_Trans_Val[8] := stage_Charge.Amount;
                                                                                        Y1_Trans_Grand_Total[8] := Y1_Trans_Grand_Total[8] + Y1S2_Trans_Val[8];
                                                                                        Y1S2_Total := Y1S2_Total + Y1S2_Trans_Val[8];
                                                                                        Y1_Grand_Total := Y1_Grand_Total + Y1S2_Trans_Val[8];

                                                                                    END ELSE
                                                                                        IF charges.Description = Y1_Trans_Txt[9] THEN BEGIN
                                                                                            Y1_Trans_Code[9] := stage_Charge.Code;
                                                                                            Y1_Trans_Txt[9] := charges.Description;
                                                                                            Y1S2_Trans_Val[9] := stage_Charge.Amount;
                                                                                            Y1_Trans_Grand_Total[9] := Y1_Trans_Grand_Total[9] + Y1S2_Trans_Val[9];
                                                                                            Y1S2_Total := Y1S2_Total + Y1S2_Trans_Val[9];
                                                                                            Y1_Grand_Total := Y1_Grand_Total + Y1S2_Trans_Val[9];

                                                                                        END ELSE
                                                                                            IF charges.Description = Y1_Trans_Txt[10] THEN BEGIN
                                                                                                Y1_Trans_Code[10] := stage_Charge.Code;
                                                                                                Y1_Trans_Txt[10] := charges.Description;
                                                                                                Y1S2_Trans_Val[10] := stage_Charge.Amount;
                                                                                                Y1_Trans_Grand_Total[10] := Y1_Trans_Grand_Total[10] + Y1S2_Trans_Val[10];
                                                                                                Y1S2_Total := Y1S2_Total + Y1S2_Trans_Val[10];
                                                                                                Y1_Grand_Total := Y1_Grand_Total + Y1S2_Trans_Val[10];

                                                                                            END ELSE
                                                                                                IF charges.Description = Y1_Trans_Txt[11] THEN BEGIN
                                                                                                    Y1_Trans_Code[11] := stage_Charge.Code;
                                                                                                    Y1_Trans_Txt[11] := charges.Description;
                                                                                                    Y1S2_Trans_Val[11] := stage_Charge.Amount;
                                                                                                    Y1_Trans_Grand_Total[11] := Y1_Trans_Grand_Total[11] + Y1S2_Trans_Val[11];
                                                                                                    Y1S2_Total := Y1S2_Total + Y1S2_Trans_Val[11];
                                                                                                    Y1_Grand_Total := Y1_Grand_Total + Y1S2_Trans_Val[11];

                                                                                                END ELSE
                                                                                                    IF charges.Description = Y1_Trans_Txt[12] THEN BEGIN
                                                                                                        Y1_Trans_Code[12] := stage_Charge.Code;
                                                                                                        Y1_Trans_Txt[12] := charges.Description;
                                                                                                        Y1S2_Trans_Val[12] := stage_Charge.Amount;
                                                                                                        Y1_Trans_Grand_Total[12] := Y1_Trans_Grand_Total[12] + Y1S2_Trans_Val[12];
                                                                                                        Y1S2_Total := Y1S2_Total + Y1S2_Trans_Val[12];
                                                                                                        Y1_Grand_Total := Y1_Grand_Total + Y1S2_Trans_Val[12];

                                                                                                    END ELSE
                                                                                                        IF charges.Description = Y1_Trans_Txt[13] THEN BEGIN
                                                                                                            Y1_Trans_Code[13] := stage_Charge.Code;
                                                                                                            Y1_Trans_Txt[13] := charges.Description;
                                                                                                            Y1S2_Trans_Val[13] := stage_Charge.Amount;
                                                                                                            Y1_Trans_Grand_Total[13] := Y1_Trans_Grand_Total[13] + Y1S2_Trans_Val[13];
                                                                                                            Y1S2_Total := Y1S2_Total + Y1S2_Trans_Val[13];
                                                                                                            Y1_Grand_Total := Y1_Grand_Total + Y1S2_Trans_Val[13];
                                                                                                        END;
                                                    END;//10
                                            END; // end for Y1S2 Charges Loop (Repeat)1
                                            UNTIL stage_Charge.NEXT = 0;
                                        END;//3
                                            // Fetch Tuition Fees for Y1S2
                                        FeeByStage.RESET;
                                        FeeByStage.SETRANGE(FeeByStage."Programme Code", Code);
                                        FeeByStage.SETRANGE(FeeByStage."Stage Code", 'Y1S2');
                                        FeeByStage.SETRANGE(FeeByStage."Settlemet Type", Settlement_Type);
                                        IF FeeByStage.FIND('-') THEN BEGIN //6
                                            Y1S2_Tuit_Val := FeeByStage."Break Down";
                                            Y1_Tuit_Total_Val := Y1_Tuit_Total_Val + Y1S2_Tuit_Val;
                                            Y1S2_Total := Y1S2_Total + Y1S2_Tuit_Val;
                                            Y1_Grand_Total := Y1_Grand_Total + Y1S2_Tuit_Val;
                                        END; // 6

                                    END;// 7
                                END; //5
                                     //**************************************END Y1 END***********************************************//
                        END ELSE
                            IF (COPYSTR(progStages.Code, 1, 2) = 'Y2') THEN BEGIN // Check if the stage is for 2nd Years
                                                                                  //clearVariables2();
                                IF Y2 = '' THEN Y2 := 'ACADEMIC YEAR - 2ND YEAR STUDENTS';


                                Y2_ItemLabel := 'ITEM';
                                Y2S1_Tuit_Caption := 'FIRST';
                                Y2S2_Tuit_Caption := 'SEMESTER';
                                Y2_Tuit_Total_Caption := '(KES)';
                                Y2S1_Tuit_Caption2 := 'SECOND';
                                Y2S2_Tuit_Caption2 := 'SEMESTER';
                                Y2_Tuit_Total_Caption2 := '(KES)';
                                Y2S1_Tuit_Caption3 := 'TOTAL PER';
                                Y2S2_Tuit_Caption3 := 'YEAR';
                                Y2_Tuit_Total_Caption3 := '(KES)';
                                Y2_Tuit_txt_lbl1 := 'A. TUITION: ';
                                Y2_Charges_txt_lbl2 := 'B. OTHER CHARGES: ';
                                Y2_Tuit_txt := 'to be paid to the University';
                                Y2_Tuit_txt2 := 'on the registration day';
                                Y2_Charges_txt := 'To bepaid to the ';
                                Y2_Charges_txt2 := 'University on the registration day';
                                Y2_Trans_txt_Footer := 'TOTAL FEE PAYABLE TO CUEA';
                                /// Fetch Charges and populate here
                                //********************************************Y2**************************************************//
                                // Fetch Charges per Stage for 1st Year 1st Sem Here
                                IF progStages.Code = 'Y2S1' THEN BEGIN //4
                                    stage_Charge.RESET;
                                    stage_Charge.SETRANGE(stage_Charge."Programme Code", Code);
                                    stage_Charge.SETRANGE(stage_Charge."Settlement Type", Settlement_Type);
                                    stage_Charge.SETFILTER(stage_Charge."Stage Code", 'Y2S1');
                                    IF stage_Charge.FIND('-') THEN BEGIN //3
                                        REPEAT
                                        BEGIN // Begin for Y2S1 Charges Loop 1
                                              // Charges for Y2S1 Exists
                                              //Fetch Name for the charge
                                            IF charges.GET(stage_Charge.Code) THEN
                                                IF NOT ((charges.Description) IN [Y2_Trans_Txt[1] .. Y2_Trans_Txt[13]]) THEN BEGIN // Charge Item Has not been Fetched already //2
                                                                                                                                   //
                                                    i2 := COMPRESSARRAY(Y2_Trans_Txt) + 1;
                                                    Y2_Trans_Code[i2] := stage_Charge.Code;
                                                    Y2_Trans_Txt[i2] := charges.Description;
                                                    Y2S1_Trans_Val[i2] := stage_Charge.Amount;
                                                    Y2_Trans_Grand_Total[i2] := Y2_Trans_Grand_Total[i2] + Y2S1_Trans_Val[i2];
                                                    Y2S1_Total := Y2S1_Total + Y2S1_Trans_Val[i2];
                                                    Y2_Grand_Total := Y2_Grand_Total + Y2S1_Trans_Val[i2];
                                                END; //2
                                        END; // end for Y2S1 Charges Loop (Repeat)1
                                        UNTIL stage_Charge.NEXT = 0;
                                    END;//3
                                        // Fetch Tuition Fees for Y2S1
                                    FeeByStage.RESET;
                                    FeeByStage.SETRANGE(FeeByStage."Programme Code", Code);
                                    FeeByStage.SETRANGE(FeeByStage."Stage Code", 'Y2S1');
                                    FeeByStage.SETRANGE(FeeByStage."Settlemet Type", Settlement_Type);
                                    IF FeeByStage.FIND('-') THEN BEGIN //6
                                        Y2S1_Tuit_Val := FeeByStage."Break Down";
                                        Y2_Tuit_Total_Val := Y2_Tuit_Total_Val + Y2S1_Tuit_Val;
                                        Y2S1_Total := Y2S1_Total + Y2S1_Tuit_Val;
                                        Y2_Grand_Total := Y2_Grand_Total + Y2S1_Tuit_Val;
                                    END; // 6
                                END ELSE
                                    IF progStages.Code = 'Y2S2' THEN BEGIN // 4/5
                                        CLEAR(counts);
                                        BEGIN // 7
                                            counts := counts + 1;
                                            // Fetch Charges per Stage for 1st Year 2nd sem Here
                                            stage_Charge.RESET;
                                            stage_Charge.SETRANGE(stage_Charge."Programme Code", Code);
                                            stage_Charge.SETRANGE(stage_Charge."Settlement Type", Settlement_Type);
                                            //stage_Charge.setrange(stage_Charge.Code,Y2_Trans_Code[counts]);
                                            stage_Charge.SETFILTER(stage_Charge."Stage Code", 'Y2S2');
                                            IF stage_Charge.FIND('-') THEN BEGIN //3
                                                REPEAT
                                                BEGIN // Begin for Y2S2 Charges Loop 1
                                                      // Charges for Y2S2 Exists
                                                      //Fetch Name for the charge
                                                      //ERROR(Y2_Trans_Txt[1]+': '+Y2_Trans_Txt[2]);
                                                    IF charges.GET(stage_Charge.Code) THEN
                                                        //IF NOT ((charges.Description) IN [Y2_Trans_Txt[1]..Y2_Trans_Txt[13]]) THEN BEGIN // Charge Item Has not been Fetched already //2
                                                        IF NOT (((charges.Description = Y2_Trans_Txt[1]) OR (charges.Description = Y2_Trans_Txt[2])
                                OR (charges.Description = Y2_Trans_Txt[3]) OR (charges.Description = Y2_Trans_Txt[4])
                                OR (charges.Description = Y2_Trans_Txt[5]) OR (charges.Description = Y2_Trans_Txt[6])
                                OR (charges.Description = Y2_Trans_Txt[7]) OR (charges.Description = Y2_Trans_Txt[8])
                                OR (charges.Description = Y2_Trans_Txt[9]) OR (charges.Description = Y2_Trans_Txt[10])
                                OR (charges.Description = Y2_Trans_Txt[11]) OR (charges.Description = Y2_Trans_Txt[12])
                                OR (charges.Description = Y2_Trans_Txt[13]))) THEN BEGIN // Charge Item Has not been Fetched already //2
                                                                                         //
                                                            i2 := (COMPRESSARRAY(Y2_Trans_Txt)) + 1;
                                                            Y2_Trans_Code[i2] := stage_Charge.Code;
                                                            Y2_Trans_Txt[i2] := charges.Description;
                                                            Y2S2_Trans_Val[i2] := stage_Charge.Amount;
                                                            Y2_Trans_Grand_Total[i2] := Y2_Trans_Grand_Total[i2] + Y2S2_Trans_Val[i2];
                                                            Y2S2_Total := Y2S2_Total + Y2S2_Trans_Val[i2];
                                                            Y2_Grand_Total := Y2_Grand_Total + Y2S2_Trans_Val[i2];
                                                        END  //2
                                                        ELSE BEGIN//10 If the Item has notyet been picked
                                                            IF charges.Description = Y2_Trans_Txt[1] THEN BEGIN
                                                                Y2_Trans_Code[1] := stage_Charge.Code;
                                                                Y2_Trans_Txt[1] := charges.Description;
                                                                Y2S2_Trans_Val[1] := stage_Charge.Amount;
                                                                Y2_Trans_Grand_Total[1] := Y2_Trans_Grand_Total[1] + Y2S2_Trans_Val[1];
                                                                Y2S2_Total := Y2S2_Total + Y2S2_Trans_Val[1];
                                                                Y2_Grand_Total := Y2_Grand_Total + Y2S2_Trans_Val[1];
                                                            END ELSE
                                                                IF charges.Description = Y2_Trans_Txt[2] THEN BEGIN
                                                                    Y2_Trans_Code[2] := stage_Charge.Code;
                                                                    Y2_Trans_Txt[2] := charges.Description;
                                                                    Y2S2_Trans_Val[2] := stage_Charge.Amount;
                                                                    Y2_Trans_Grand_Total[2] := Y2_Trans_Grand_Total[2] + Y2S2_Trans_Val[2];
                                                                    Y2S2_Total := Y2S2_Total + Y2S2_Trans_Val[2];
                                                                    Y2_Grand_Total := Y2_Grand_Total + Y2S2_Trans_Val[2];
                                                                END ELSE
                                                                    IF charges.Description = Y2_Trans_Txt[3] THEN BEGIN
                                                                        Y2_Trans_Code[3] := stage_Charge.Code;
                                                                        Y2_Trans_Txt[3] := charges.Description;
                                                                        Y2S2_Trans_Val[3] := stage_Charge.Amount;
                                                                        Y2_Trans_Grand_Total[3] := Y2_Trans_Grand_Total[3] + Y2S2_Trans_Val[3];
                                                                        Y2S2_Total := Y2S2_Total + Y2S2_Trans_Val[3];
                                                                        Y2_Grand_Total := Y2_Grand_Total + Y2S2_Trans_Val[3];

                                                                    END ELSE
                                                                        IF charges.Description = Y2_Trans_Txt[4] THEN BEGIN
                                                                            Y2_Trans_Code[4] := stage_Charge.Code;
                                                                            Y2_Trans_Txt[4] := charges.Description;
                                                                            Y2S2_Trans_Val[4] := stage_Charge.Amount;
                                                                            Y2_Trans_Grand_Total[4] := Y2_Trans_Grand_Total[4] + Y2S2_Trans_Val[4];
                                                                            Y2S2_Total := Y2S2_Total + Y2S2_Trans_Val[4];
                                                                            Y2_Grand_Total := Y2_Grand_Total + Y2S2_Trans_Val[4];

                                                                        END ELSE
                                                                            IF charges.Description = Y2_Trans_Txt[5] THEN BEGIN
                                                                                Y2_Trans_Code[5] := stage_Charge.Code;
                                                                                Y2_Trans_Txt[5] := charges.Description;
                                                                                Y2S2_Trans_Val[5] := stage_Charge.Amount;
                                                                                Y2_Trans_Grand_Total[5] := Y2_Trans_Grand_Total[5] + Y2S2_Trans_Val[5];
                                                                                Y2S2_Total := Y2S2_Total + Y2S2_Trans_Val[5];
                                                                                Y2_Grand_Total := Y2_Grand_Total + Y2S2_Trans_Val[5];

                                                                            END ELSE
                                                                                IF charges.Description = Y2_Trans_Txt[6] THEN BEGIN
                                                                                    Y2_Trans_Code[6] := stage_Charge.Code;
                                                                                    Y2_Trans_Txt[6] := charges.Description;
                                                                                    Y2S2_Trans_Val[6] := stage_Charge.Amount;
                                                                                    Y2_Trans_Grand_Total[6] := Y2_Trans_Grand_Total[6] + Y2S2_Trans_Val[6];
                                                                                    Y2S2_Total := Y2S2_Total + Y2S2_Trans_Val[6];
                                                                                    Y2_Grand_Total := Y2_Grand_Total + Y2S2_Trans_Val[6];

                                                                                END ELSE
                                                                                    IF charges.Description = Y2_Trans_Txt[7] THEN BEGIN
                                                                                        Y2_Trans_Code[7] := stage_Charge.Code;
                                                                                        Y2_Trans_Txt[7] := charges.Description;
                                                                                        Y2S2_Trans_Val[7] := stage_Charge.Amount;
                                                                                        Y2_Trans_Grand_Total[7] := Y2_Trans_Grand_Total[7] + Y2S2_Trans_Val[7];
                                                                                        Y2S2_Total := Y2S2_Total + Y2S2_Trans_Val[7];
                                                                                        Y2_Grand_Total := Y2_Grand_Total + Y2S2_Trans_Val[7];

                                                                                    END ELSE
                                                                                        IF charges.Description = Y2_Trans_Txt[8] THEN BEGIN
                                                                                            Y2_Trans_Code[8] := stage_Charge.Code;
                                                                                            Y2_Trans_Txt[8] := charges.Description;
                                                                                            Y2S2_Trans_Val[8] := stage_Charge.Amount;
                                                                                            Y2_Trans_Grand_Total[8] := Y2_Trans_Grand_Total[8] + Y2S2_Trans_Val[8];
                                                                                            Y2S2_Total := Y2S2_Total + Y2S2_Trans_Val[8];
                                                                                            Y2_Grand_Total := Y2_Grand_Total + Y2S2_Trans_Val[8];

                                                                                        END ELSE
                                                                                            IF charges.Description = Y2_Trans_Txt[9] THEN BEGIN
                                                                                                Y2_Trans_Code[9] := stage_Charge.Code;
                                                                                                Y2_Trans_Txt[9] := charges.Description;
                                                                                                Y2S2_Trans_Val[9] := stage_Charge.Amount;
                                                                                                Y2_Trans_Grand_Total[9] := Y2_Trans_Grand_Total[9] + Y2S2_Trans_Val[9];
                                                                                                Y2S2_Total := Y2S2_Total + Y2S2_Trans_Val[9];
                                                                                                Y2_Grand_Total := Y2_Grand_Total + Y2S2_Trans_Val[9];

                                                                                            END ELSE
                                                                                                IF charges.Description = Y2_Trans_Txt[10] THEN BEGIN
                                                                                                    Y2_Trans_Code[10] := stage_Charge.Code;
                                                                                                    Y2_Trans_Txt[10] := charges.Description;
                                                                                                    Y2S2_Trans_Val[10] := stage_Charge.Amount;
                                                                                                    Y2_Trans_Grand_Total[10] := Y2_Trans_Grand_Total[10] + Y2S2_Trans_Val[10];
                                                                                                    Y2S2_Total := Y2S2_Total + Y2S2_Trans_Val[10];
                                                                                                    Y2_Grand_Total := Y2_Grand_Total + Y2S2_Trans_Val[10];

                                                                                                END ELSE
                                                                                                    IF charges.Description = Y2_Trans_Txt[11] THEN BEGIN
                                                                                                        Y2_Trans_Code[11] := stage_Charge.Code;
                                                                                                        Y2_Trans_Txt[11] := charges.Description;
                                                                                                        Y2S2_Trans_Val[11] := stage_Charge.Amount;
                                                                                                        Y2_Trans_Grand_Total[11] := Y2_Trans_Grand_Total[11] + Y2S2_Trans_Val[11];
                                                                                                        Y2S2_Total := Y2S2_Total + Y2S2_Trans_Val[11];
                                                                                                        Y2_Grand_Total := Y2_Grand_Total + Y2S2_Trans_Val[11];

                                                                                                    END ELSE
                                                                                                        IF charges.Description = Y2_Trans_Txt[12] THEN BEGIN
                                                                                                            Y2_Trans_Code[12] := stage_Charge.Code;
                                                                                                            Y2_Trans_Txt[12] := charges.Description;
                                                                                                            Y2S2_Trans_Val[12] := stage_Charge.Amount;
                                                                                                            Y2_Trans_Grand_Total[12] := Y2_Trans_Grand_Total[12] + Y2S2_Trans_Val[12];
                                                                                                            Y2S2_Total := Y2S2_Total + Y2S2_Trans_Val[12];
                                                                                                            Y2_Grand_Total := Y2_Grand_Total + Y2S2_Trans_Val[12];

                                                                                                        END ELSE
                                                                                                            IF charges.Description = Y2_Trans_Txt[13] THEN BEGIN
                                                                                                                Y2_Trans_Code[13] := stage_Charge.Code;
                                                                                                                Y2_Trans_Txt[13] := charges.Description;
                                                                                                                Y2S2_Trans_Val[13] := stage_Charge.Amount;
                                                                                                                Y2_Trans_Grand_Total[13] := Y2_Trans_Grand_Total[13] + Y2S2_Trans_Val[13];
                                                                                                                Y2S2_Total := Y2S2_Total + Y2S2_Trans_Val[13];
                                                                                                                Y2_Grand_Total := Y2_Grand_Total + Y2S2_Trans_Val[13];
                                                                                                            END;
                                                        END;//10
                                                END; // end for Y2S2 Charges Loop (Repeat)1
                                                UNTIL stage_Charge.NEXT = 0;
                                            END;//3
                                                // Fetch Tuition Fees for Y2S2
                                            FeeByStage.RESET;
                                            FeeByStage.SETRANGE(FeeByStage."Programme Code", Code);
                                            FeeByStage.SETRANGE(FeeByStage."Stage Code", 'Y2S2');
                                            FeeByStage.SETRANGE(FeeByStage."Settlemet Type", Settlement_Type);
                                            IF FeeByStage.FIND('-') THEN BEGIN //6
                                                Y2S2_Tuit_Val := FeeByStage."Break Down";
                                                Y2_Tuit_Total_Val := Y2_Tuit_Total_Val + Y2S2_Tuit_Val;
                                                Y2S2_Total := Y2S2_Total + Y2S2_Tuit_Val;
                                                Y2_Grand_Total := Y2_Grand_Total + Y2S2_Tuit_Val;
                                            END; // 6

                                        END;// 7
                                    END; //5
                                         //**************************************END Y2 END***********************************************//
                            END ELSE
                                IF (COPYSTR(progStages.Code, 1, 2) = 'Y3') THEN BEGIN // Check if the stage is for 3rd Years
                                                                                      // clearVariables3();
                                    IF Y3 = '' THEN Y3 := 'ACADEMIC YEAR - 3RD YEAR STUDENTS';


                                    Y3_ItemLabel := 'ITEM';
                                    Y3S1_Tuit_Caption := 'FIRST';
                                    Y3S2_Tuit_Caption := 'SEMESTER';
                                    Y3_Tuit_Total_Caption := '(KES)';
                                    Y3S1_Tuit_Caption2 := 'SECOND';
                                    Y3S2_Tuit_Caption2 := 'SEMESTER';
                                    Y3_Tuit_Total_Caption2 := '(KES)';
                                    Y3S1_Tuit_Caption3 := 'TOTAL PER';
                                    Y3S2_Tuit_Caption3 := 'YEAR';
                                    Y3_Tuit_Total_Caption3 := '(KES)';
                                    Y3_Tuit_txt_lbl1 := 'A. TUITION: ';
                                    Y3_Charges_txt_lbl2 := 'B. OTHER CHARGES: ';
                                    Y3_Tuit_txt := 'to be paid to the University';
                                    Y3_Tuit_txt2 := 'on the registration day';
                                    Y3_Charges_txt := 'To bepaid to the ';
                                    Y3_Charges_txt2 := 'University on the registration day';
                                    Y3_Trans_txt_Footer := 'TOTAL FEE PAYABLE TO CUEA';
                                    /// Fetch Charges and populate here
                                    //********************************************Y3**************************************************//
                                    // Fetch Charges per Stage for 1st Year 1st Sem Here
                                    IF progStages.Code = 'Y3S1' THEN BEGIN //4
                                        stage_Charge.RESET;
                                        stage_Charge.SETRANGE(stage_Charge."Programme Code", Code);
                                        stage_Charge.SETRANGE(stage_Charge."Settlement Type", Settlement_Type);
                                        stage_Charge.SETFILTER(stage_Charge."Stage Code", 'Y3S1');
                                        IF stage_Charge.FIND('-') THEN BEGIN //3
                                            REPEAT
                                            BEGIN // Begin for Y3S1 Charges Loop 1
                                                  // Charges for Y3S1 Exists
                                                  //Fetch Name for the charge
                                                IF charges.GET(stage_Charge.Code) THEN
                                                    IF NOT ((charges.Description) IN [Y3_Trans_Txt[1] .. Y3_Trans_Txt[13]]) THEN BEGIN // Charge Item Has not been Fetched already //2
                                                                                                                                       //
                                                        i3 := COMPRESSARRAY(Y3_Trans_Txt) + 1;
                                                        Y3_Trans_Code[i3] := stage_Charge.Code;
                                                        Y3_Trans_Txt[i3] := charges.Description;
                                                        Y3S1_Trans_Val[i3] := stage_Charge.Amount;
                                                        Y3_Trans_Grand_Total[i3] := Y3_Trans_Grand_Total[i3] + Y3S1_Trans_Val[i3];
                                                        Y3S1_Total := Y3S1_Total + Y3S1_Trans_Val[i3];
                                                        Y3_Grand_Total := Y3_Grand_Total + Y3S1_Trans_Val[i3];
                                                    END; //2
                                            END; // end for Y3S1 Charges Loop (Repeat)1
                                            UNTIL stage_Charge.NEXT = 0;
                                        END;//3
                                            // Fetch Tuition Fees for Y3S1
                                        FeeByStage.RESET;
                                        FeeByStage.SETRANGE(FeeByStage."Programme Code", Code);
                                        FeeByStage.SETRANGE(FeeByStage."Stage Code", 'Y3S1');
                                        FeeByStage.SETRANGE(FeeByStage."Settlemet Type", Settlement_Type);
                                        IF FeeByStage.FIND('-') THEN BEGIN //6
                                            Y3S1_Tuit_Val := FeeByStage."Break Down";
                                            Y3_Tuit_Total_Val := Y3_Tuit_Total_Val + Y3S1_Tuit_Val;
                                            Y3S1_Total := Y3S1_Total + Y3S1_Tuit_Val;
                                            Y3_Grand_Total := Y3_Grand_Total + Y3S1_Tuit_Val;
                                        END; // 6
                                    END ELSE
                                        IF progStages.Code = 'Y3S2' THEN BEGIN // 4/5
                                            CLEAR(counts);
                                            BEGIN // 7
                                                counts := counts + 1;
                                                // Fetch Charges per Stage for 1st Year 2nd sem Here
                                                stage_Charge.RESET;
                                                stage_Charge.SETRANGE(stage_Charge."Programme Code", Code);
                                                stage_Charge.SETRANGE(stage_Charge."Settlement Type", Settlement_Type);
                                                //stage_Charge.setrange(stage_Charge.Code,Y3_Trans_Code[counts]);
                                                stage_Charge.SETFILTER(stage_Charge."Stage Code", 'Y3S2');
                                                IF stage_Charge.FIND('-') THEN BEGIN //3
                                                    REPEAT
                                                    BEGIN // Begin for Y3S2 Charges Loop 1
                                                          // Charges for Y3S2 Exists
                                                          //Fetch Name for the charge
                                                          //ERROR(Y3_Trans_Txt[1]+': '+Y3_Trans_Txt[2]);
                                                        IF charges.GET(stage_Charge.Code) THEN
                                                            //IF NOT ((charges.Description) IN [Y3_Trans_Txt[1]..Y3_Trans_Txt[13]]) THEN BEGIN // Charge Item Has not been Fetched already //2
                                                            IF NOT (((charges.Description = Y3_Trans_Txt[1]) OR (charges.Description = Y3_Trans_Txt[2])
                                OR (charges.Description = Y3_Trans_Txt[3]) OR (charges.Description = Y3_Trans_Txt[4])
                                OR (charges.Description = Y3_Trans_Txt[5]) OR (charges.Description = Y3_Trans_Txt[6])
                                OR (charges.Description = Y3_Trans_Txt[7]) OR (charges.Description = Y3_Trans_Txt[8])
                                OR (charges.Description = Y3_Trans_Txt[9]) OR (charges.Description = Y3_Trans_Txt[10])
                                OR (charges.Description = Y3_Trans_Txt[11]) OR (charges.Description = Y3_Trans_Txt[12])
                                OR (charges.Description = Y3_Trans_Txt[13]))) THEN BEGIN // Charge Item Has not been Fetched already //2
                                                                                         //
                                                                i3 := (COMPRESSARRAY(Y3_Trans_Txt)) + 1;
                                                                Y3_Trans_Code[i3] := stage_Charge.Code;
                                                                Y3_Trans_Txt[i3] := charges.Description;
                                                                Y3S2_Trans_Val[i3] := stage_Charge.Amount;
                                                                Y3_Trans_Grand_Total[i3] := Y3_Trans_Grand_Total[i3] + Y3S2_Trans_Val[i3];
                                                                Y3S2_Total := Y3S2_Total + Y3S2_Trans_Val[i3];
                                                                Y3_Grand_Total := Y3_Grand_Total + Y3S2_Trans_Val[i3];
                                                            END  //2
                                                            ELSE BEGIN//10 If the Item has notyet been picked
                                                                IF charges.Description = Y3_Trans_Txt[1] THEN BEGIN
                                                                    Y3_Trans_Code[1] := stage_Charge.Code;
                                                                    Y3_Trans_Txt[1] := charges.Description;
                                                                    Y3S2_Trans_Val[1] := stage_Charge.Amount;
                                                                    Y3_Trans_Grand_Total[1] := Y3_Trans_Grand_Total[1] + Y3S2_Trans_Val[1];
                                                                    Y3S2_Total := Y3S2_Total + Y3S2_Trans_Val[1];
                                                                    Y3_Grand_Total := Y3_Grand_Total + Y3S2_Trans_Val[1];
                                                                END ELSE
                                                                    IF charges.Description = Y3_Trans_Txt[2] THEN BEGIN
                                                                        Y3_Trans_Code[2] := stage_Charge.Code;
                                                                        Y3_Trans_Txt[2] := charges.Description;
                                                                        Y3S2_Trans_Val[2] := stage_Charge.Amount;
                                                                        Y3_Trans_Grand_Total[2] := Y3_Trans_Grand_Total[2] + Y3S2_Trans_Val[2];
                                                                        Y3S2_Total := Y3S2_Total + Y3S2_Trans_Val[2];
                                                                        Y3_Grand_Total := Y3_Grand_Total + Y3S2_Trans_Val[2];
                                                                    END ELSE
                                                                        IF charges.Description = Y3_Trans_Txt[3] THEN BEGIN
                                                                            Y3_Trans_Code[3] := stage_Charge.Code;
                                                                            Y3_Trans_Txt[3] := charges.Description;
                                                                            Y3S2_Trans_Val[3] := stage_Charge.Amount;
                                                                            Y3_Trans_Grand_Total[3] := Y3_Trans_Grand_Total[3] + Y3S2_Trans_Val[3];
                                                                            Y3S2_Total := Y3S2_Total + Y3S2_Trans_Val[3];
                                                                            Y3_Grand_Total := Y3_Grand_Total + Y3S2_Trans_Val[3];

                                                                        END ELSE
                                                                            IF charges.Description = Y3_Trans_Txt[4] THEN BEGIN
                                                                                Y3_Trans_Code[4] := stage_Charge.Code;
                                                                                Y3_Trans_Txt[4] := charges.Description;
                                                                                Y3S2_Trans_Val[4] := stage_Charge.Amount;
                                                                                Y3_Trans_Grand_Total[4] := Y3_Trans_Grand_Total[4] + Y3S2_Trans_Val[4];
                                                                                Y3S2_Total := Y3S2_Total + Y3S2_Trans_Val[4];
                                                                                Y3_Grand_Total := Y3_Grand_Total + Y3S2_Trans_Val[4];

                                                                            END ELSE
                                                                                IF charges.Description = Y3_Trans_Txt[5] THEN BEGIN
                                                                                    Y3_Trans_Code[5] := stage_Charge.Code;
                                                                                    Y3_Trans_Txt[5] := charges.Description;
                                                                                    Y3S2_Trans_Val[5] := stage_Charge.Amount;
                                                                                    Y3_Trans_Grand_Total[5] := Y3_Trans_Grand_Total[5] + Y3S2_Trans_Val[5];
                                                                                    Y3S2_Total := Y3S2_Total + Y3S2_Trans_Val[5];
                                                                                    Y3_Grand_Total := Y3_Grand_Total + Y3S2_Trans_Val[5];

                                                                                END ELSE
                                                                                    IF charges.Description = Y3_Trans_Txt[6] THEN BEGIN
                                                                                        Y3_Trans_Code[6] := stage_Charge.Code;
                                                                                        Y3_Trans_Txt[6] := charges.Description;
                                                                                        Y3S2_Trans_Val[6] := stage_Charge.Amount;
                                                                                        Y3_Trans_Grand_Total[6] := Y3_Trans_Grand_Total[6] + Y3S2_Trans_Val[6];
                                                                                        Y3S2_Total := Y3S2_Total + Y3S2_Trans_Val[6];
                                                                                        Y3_Grand_Total := Y3_Grand_Total + Y3S2_Trans_Val[6];

                                                                                    END ELSE
                                                                                        IF charges.Description = Y3_Trans_Txt[7] THEN BEGIN
                                                                                            Y3_Trans_Code[7] := stage_Charge.Code;
                                                                                            Y3_Trans_Txt[7] := charges.Description;
                                                                                            Y3S2_Trans_Val[7] := stage_Charge.Amount;
                                                                                            Y3_Trans_Grand_Total[7] := Y3_Trans_Grand_Total[7] + Y3S2_Trans_Val[7];
                                                                                            Y3S2_Total := Y3S2_Total + Y3S2_Trans_Val[7];
                                                                                            Y3_Grand_Total := Y3_Grand_Total + Y3S2_Trans_Val[7];

                                                                                        END ELSE
                                                                                            IF charges.Description = Y3_Trans_Txt[8] THEN BEGIN
                                                                                                Y3_Trans_Code[8] := stage_Charge.Code;
                                                                                                Y3_Trans_Txt[8] := charges.Description;
                                                                                                Y3S2_Trans_Val[8] := stage_Charge.Amount;
                                                                                                Y3_Trans_Grand_Total[8] := Y3_Trans_Grand_Total[8] + Y3S2_Trans_Val[8];
                                                                                                Y3S2_Total := Y3S2_Total + Y3S2_Trans_Val[8];
                                                                                                Y3_Grand_Total := Y3_Grand_Total + Y3S2_Trans_Val[8];

                                                                                            END ELSE
                                                                                                IF charges.Description = Y3_Trans_Txt[9] THEN BEGIN
                                                                                                    Y3_Trans_Code[9] := stage_Charge.Code;
                                                                                                    Y3_Trans_Txt[9] := charges.Description;
                                                                                                    Y3S2_Trans_Val[9] := stage_Charge.Amount;
                                                                                                    Y3_Trans_Grand_Total[9] := Y3_Trans_Grand_Total[9] + Y3S2_Trans_Val[9];
                                                                                                    Y3S2_Total := Y3S2_Total + Y3S2_Trans_Val[9];
                                                                                                    Y3_Grand_Total := Y3_Grand_Total + Y3S2_Trans_Val[9];

                                                                                                END ELSE
                                                                                                    IF charges.Description = Y3_Trans_Txt[10] THEN BEGIN
                                                                                                        Y3_Trans_Code[10] := stage_Charge.Code;
                                                                                                        Y3_Trans_Txt[10] := charges.Description;
                                                                                                        Y3S2_Trans_Val[10] := stage_Charge.Amount;
                                                                                                        Y3_Trans_Grand_Total[10] := Y3_Trans_Grand_Total[10] + Y3S2_Trans_Val[10];
                                                                                                        Y3S2_Total := Y3S2_Total + Y3S2_Trans_Val[10];
                                                                                                        Y3_Grand_Total := Y3_Grand_Total + Y3S2_Trans_Val[10];

                                                                                                    END ELSE
                                                                                                        IF charges.Description = Y3_Trans_Txt[11] THEN BEGIN
                                                                                                            Y3_Trans_Code[11] := stage_Charge.Code;
                                                                                                            Y3_Trans_Txt[11] := charges.Description;
                                                                                                            Y3S2_Trans_Val[11] := stage_Charge.Amount;
                                                                                                            Y3_Trans_Grand_Total[11] := Y3_Trans_Grand_Total[11] + Y3S2_Trans_Val[11];
                                                                                                            Y3S2_Total := Y3S2_Total + Y3S2_Trans_Val[11];
                                                                                                            Y3_Grand_Total := Y3_Grand_Total + Y3S2_Trans_Val[11];

                                                                                                        END ELSE
                                                                                                            IF charges.Description = Y3_Trans_Txt[12] THEN BEGIN
                                                                                                                Y3_Trans_Code[12] := stage_Charge.Code;
                                                                                                                Y3_Trans_Txt[12] := charges.Description;
                                                                                                                Y3S2_Trans_Val[12] := stage_Charge.Amount;
                                                                                                                Y3_Trans_Grand_Total[12] := Y3_Trans_Grand_Total[12] + Y3S2_Trans_Val[12];
                                                                                                                Y3S2_Total := Y3S2_Total + Y3S2_Trans_Val[12];
                                                                                                                Y3_Grand_Total := Y3_Grand_Total + Y3S2_Trans_Val[12];

                                                                                                            END ELSE
                                                                                                                IF charges.Description = Y3_Trans_Txt[13] THEN BEGIN
                                                                                                                    Y3_Trans_Code[13] := stage_Charge.Code;
                                                                                                                    Y3_Trans_Txt[13] := charges.Description;
                                                                                                                    Y3S2_Trans_Val[13] := stage_Charge.Amount;
                                                                                                                    Y3_Trans_Grand_Total[13] := Y3_Trans_Grand_Total[13] + Y3S2_Trans_Val[13];
                                                                                                                    Y3S2_Total := Y3S2_Total + Y3S2_Trans_Val[13];
                                                                                                                    Y3_Grand_Total := Y3_Grand_Total + Y3S2_Trans_Val[13];
                                                                                                                END;
                                                            END;//10
                                                    END; // end for Y3S2 Charges Loop (Repeat)1
                                                    UNTIL stage_Charge.NEXT = 0;
                                                END;//3
                                                    // Fetch Tuition Fees for Y3S2
                                                FeeByStage.RESET;
                                                FeeByStage.SETRANGE(FeeByStage."Programme Code", Code);
                                                FeeByStage.SETRANGE(FeeByStage."Stage Code", 'Y3S2');
                                                FeeByStage.SETRANGE(FeeByStage."Settlemet Type", Settlement_Type);
                                                IF FeeByStage.FIND('-') THEN BEGIN //6
                                                    Y3S2_Tuit_Val := FeeByStage."Break Down";
                                                    Y3_Tuit_Total_Val := Y3_Tuit_Total_Val + Y3S2_Tuit_Val;
                                                    Y3S2_Total := Y3S2_Total + Y3S2_Tuit_Val;
                                                    Y3_Grand_Total := Y3_Grand_Total + Y3S2_Tuit_Val;
                                                END; // 6

                                            END;// 7
                                        END; //5
                                             //**************************************END Y3 END***********************************************//
                                END ELSE
                                    IF (COPYSTR(progStages.Code, 1, 2) = 'Y4') THEN BEGIN // Check if the stage is for 4th Years
                                                                                          //clearVariables4();
                                        IF Y4 = '' THEN Y4 := 'ACADEMIC YEAR - 4TH YEAR STUDENTS';


                                        Y4_ItemLabel := 'ITEM';
                                        Y4S1_Tuit_Caption := 'FIRST';
                                        Y4S2_Tuit_Caption := 'SEMESTER';
                                        Y4_Tuit_Total_Caption := '(KES)';
                                        Y4S1_Tuit_Caption2 := 'SECOND';
                                        Y4S2_Tuit_Caption2 := 'SEMESTER';
                                        Y4_Tuit_Total_Caption2 := '(KES)';
                                        Y4S1_Tuit_Caption3 := 'TOTAL PER';
                                        Y4S2_Tuit_Caption3 := 'YEAR';
                                        Y4_Tuit_Total_Caption3 := '(KES)';
                                        Y4_Tuit_txt_lbl1 := 'A. TUITION: ';
                                        Y4_Charges_txt_lbl2 := 'B. OTHER CHARGES: ';
                                        Y4_Tuit_txt := 'to be paid to the University';
                                        Y4_Tuit_txt2 := 'on the registration day';
                                        Y4_Charges_txt := 'To bepaid to the ';
                                        Y4_Charges_txt2 := 'University on the registration day';
                                        Y4_Trans_txt_Footer := 'TOTAL FEE PAYABLE TO CUEA';
                                        /// Fetch Charges and populate here
                                        //********************************************Y4**************************************************//
                                        // Fetch Charges per Stage for 1st Year 1st Sem Here
                                        IF progStages.Code = 'Y4S1' THEN BEGIN //4
                                            stage_Charge.RESET;
                                            stage_Charge.SETRANGE(stage_Charge."Programme Code", Code);
                                            stage_Charge.SETRANGE(stage_Charge."Settlement Type", Settlement_Type);
                                            stage_Charge.SETFILTER(stage_Charge."Stage Code", 'Y4S1');
                                            IF stage_Charge.FIND('-') THEN BEGIN //3
                                                REPEAT
                                                BEGIN // Begin for Y4S1 Charges Loop 1
                                                      // Charges for Y4S1 Exists
                                                      //Fetch Name for the charge
                                                    IF charges.GET(stage_Charge.Code) THEN
                                                        IF NOT ((charges.Description) IN [Y4_Trans_Txt[1] .. Y4_Trans_Txt[13]]) THEN BEGIN // Charge Item Has not been Fetched already //2
                                                                                                                                           //
                                                            i4 := COMPRESSARRAY(Y4_Trans_Txt) + 1;
                                                            Y4_Trans_Code[i4] := stage_Charge.Code;
                                                            Y4_Trans_Txt[i4] := charges.Description;
                                                            Y4S1_Trans_Val[i4] := stage_Charge.Amount;
                                                            Y4_Trans_Grand_Total[i4] := Y4_Trans_Grand_Total[i4] + Y4S1_Trans_Val[i4];
                                                            Y4S1_Total := Y4S1_Total + Y4S1_Trans_Val[i4];
                                                            Y4_Grand_Total := Y4_Grand_Total + Y4S1_Trans_Val[i4];
                                                        END; //2
                                                END; // end for Y4S1 Charges Loop (Repeat)1
                                                UNTIL stage_Charge.NEXT = 0;
                                            END;//3
                                                // Fetch Tuition Fees for Y4S1
                                            FeeByStage.RESET;
                                            FeeByStage.SETRANGE(FeeByStage."Programme Code", Code);
                                            FeeByStage.SETRANGE(FeeByStage."Stage Code", 'Y4S1');
                                            FeeByStage.SETRANGE(FeeByStage."Settlemet Type", Settlement_Type);
                                            IF FeeByStage.FIND('-') THEN BEGIN //6
                                                Y4S1_Tuit_Val := FeeByStage."Break Down";
                                                Y4_Tuit_Total_Val := Y4_Tuit_Total_Val + Y4S1_Tuit_Val;
                                                Y4S1_Total := Y4S1_Total + Y4S1_Tuit_Val;
                                                Y4_Grand_Total := Y4_Grand_Total + Y4S1_Tuit_Val;
                                            END; // 6
                                        END ELSE
                                            IF progStages.Code = 'Y4S2' THEN BEGIN // 4/5
                                                CLEAR(counts);
                                                BEGIN // 7
                                                    counts := counts + 1;
                                                    // Fetch Charges per Stage for 1st Year 2nd sem Here
                                                    stage_Charge.RESET;
                                                    stage_Charge.SETRANGE(stage_Charge."Programme Code", Code);
                                                    stage_Charge.SETRANGE(stage_Charge."Settlement Type", Settlement_Type);
                                                    //stage_Charge.setrange(stage_Charge.Code,Y4_Trans_Code[counts]);
                                                    stage_Charge.SETFILTER(stage_Charge."Stage Code", 'Y4S2');
                                                    IF stage_Charge.FIND('-') THEN BEGIN //3
                                                        REPEAT
                                                        BEGIN // Begin for Y4S2 Charges Loop 1
                                                              // Charges for Y4S2 Exists
                                                              //Fetch Name for the charge
                                                              //ERROR(Y4_Trans_Txt[1]+': '+Y4_Trans_Txt[2]);
                                                            IF charges.GET(stage_Charge.Code) THEN
                                                                //IF NOT ((charges.Description) IN [Y4_Trans_Txt[1]..Y4_Trans_Txt[13]]) THEN BEGIN // Charge Item Has not been Fetched already //2
                                                                IF NOT (((charges.Description = Y4_Trans_Txt[1]) OR (charges.Description = Y4_Trans_Txt[2])
                                OR (charges.Description = Y4_Trans_Txt[3]) OR (charges.Description = Y4_Trans_Txt[4])
                                OR (charges.Description = Y4_Trans_Txt[5]) OR (charges.Description = Y4_Trans_Txt[6])
                                OR (charges.Description = Y4_Trans_Txt[7]) OR (charges.Description = Y4_Trans_Txt[8])
                                OR (charges.Description = Y4_Trans_Txt[9]) OR (charges.Description = Y4_Trans_Txt[10])
                                OR (charges.Description = Y4_Trans_Txt[11]) OR (charges.Description = Y4_Trans_Txt[12])
                                OR (charges.Description = Y4_Trans_Txt[13]))) THEN BEGIN // Charge Item Has not been Fetched already //2
                                                                                         //
                                                                    i4 := (COMPRESSARRAY(Y4_Trans_Txt)) + 1;
                                                                    Y4_Trans_Code[i4] := stage_Charge.Code;
                                                                    Y4_Trans_Txt[i4] := charges.Description;
                                                                    Y4S2_Trans_Val[i4] := stage_Charge.Amount;
                                                                    Y4_Trans_Grand_Total[i4] := Y4_Trans_Grand_Total[i4] + Y4S2_Trans_Val[i4];
                                                                    Y4S2_Total := Y4S2_Total + Y4S2_Trans_Val[i4];
                                                                    Y4_Grand_Total := Y4_Grand_Total + Y4S2_Trans_Val[i4];
                                                                END  //2
                                                                ELSE BEGIN//10 If the Item has notyet been picked
                                                                    IF charges.Description = Y4_Trans_Txt[1] THEN BEGIN
                                                                        Y4_Trans_Code[1] := stage_Charge.Code;
                                                                        Y4_Trans_Txt[1] := charges.Description;
                                                                        Y4S2_Trans_Val[1] := stage_Charge.Amount;
                                                                        Y4_Trans_Grand_Total[1] := Y4_Trans_Grand_Total[1] + Y4S2_Trans_Val[1];
                                                                        Y4S2_Total := Y4S2_Total + Y4S2_Trans_Val[1];
                                                                        Y4_Grand_Total := Y4_Grand_Total + Y4S2_Trans_Val[1];
                                                                    END ELSE
                                                                        IF charges.Description = Y4_Trans_Txt[2] THEN BEGIN
                                                                            Y4_Trans_Code[2] := stage_Charge.Code;
                                                                            Y4_Trans_Txt[2] := charges.Description;
                                                                            Y4S2_Trans_Val[2] := stage_Charge.Amount;
                                                                            Y4_Trans_Grand_Total[2] := Y4_Trans_Grand_Total[2] + Y4S2_Trans_Val[2];
                                                                            Y4S2_Total := Y4S2_Total + Y4S2_Trans_Val[2];
                                                                            Y4_Grand_Total := Y4_Grand_Total + Y4S2_Trans_Val[2];
                                                                        END ELSE
                                                                            IF charges.Description = Y4_Trans_Txt[3] THEN BEGIN
                                                                                Y4_Trans_Code[3] := stage_Charge.Code;
                                                                                Y4_Trans_Txt[3] := charges.Description;
                                                                                Y4S2_Trans_Val[3] := stage_Charge.Amount;
                                                                                Y4_Trans_Grand_Total[3] := Y4_Trans_Grand_Total[3] + Y4S2_Trans_Val[3];
                                                                                Y4S2_Total := Y4S2_Total + Y4S2_Trans_Val[3];
                                                                                Y4_Grand_Total := Y4_Grand_Total + Y4S2_Trans_Val[3];

                                                                            END ELSE
                                                                                IF charges.Description = Y4_Trans_Txt[4] THEN BEGIN
                                                                                    Y4_Trans_Code[4] := stage_Charge.Code;
                                                                                    Y4_Trans_Txt[4] := charges.Description;
                                                                                    Y4S2_Trans_Val[4] := stage_Charge.Amount;
                                                                                    Y4_Trans_Grand_Total[4] := Y4_Trans_Grand_Total[4] + Y4S2_Trans_Val[4];
                                                                                    Y4S2_Total := Y4S2_Total + Y4S2_Trans_Val[4];
                                                                                    Y4_Grand_Total := Y4_Grand_Total + Y4S2_Trans_Val[4];

                                                                                END ELSE
                                                                                    IF charges.Description = Y4_Trans_Txt[5] THEN BEGIN
                                                                                        Y4_Trans_Code[5] := stage_Charge.Code;
                                                                                        Y4_Trans_Txt[5] := charges.Description;
                                                                                        Y4S2_Trans_Val[5] := stage_Charge.Amount;
                                                                                        Y4_Trans_Grand_Total[5] := Y4_Trans_Grand_Total[5] + Y4S2_Trans_Val[5];
                                                                                        Y4S2_Total := Y4S2_Total + Y4S2_Trans_Val[5];
                                                                                        Y4_Grand_Total := Y4_Grand_Total + Y4S2_Trans_Val[5];

                                                                                    END ELSE
                                                                                        IF charges.Description = Y4_Trans_Txt[6] THEN BEGIN
                                                                                            Y4_Trans_Code[6] := stage_Charge.Code;
                                                                                            Y4_Trans_Txt[6] := charges.Description;
                                                                                            Y4S2_Trans_Val[6] := stage_Charge.Amount;
                                                                                            Y4_Trans_Grand_Total[6] := Y4_Trans_Grand_Total[6] + Y4S2_Trans_Val[6];
                                                                                            Y4S2_Total := Y4S2_Total + Y4S2_Trans_Val[6];
                                                                                            Y4_Grand_Total := Y4_Grand_Total + Y4S2_Trans_Val[6];

                                                                                        END ELSE
                                                                                            IF charges.Description = Y4_Trans_Txt[7] THEN BEGIN
                                                                                                Y4_Trans_Code[7] := stage_Charge.Code;
                                                                                                Y4_Trans_Txt[7] := charges.Description;
                                                                                                Y4S2_Trans_Val[7] := stage_Charge.Amount;
                                                                                                Y4_Trans_Grand_Total[7] := Y4_Trans_Grand_Total[7] + Y4S2_Trans_Val[7];
                                                                                                Y4S2_Total := Y4S2_Total + Y4S2_Trans_Val[7];
                                                                                                Y4_Grand_Total := Y4_Grand_Total + Y4S2_Trans_Val[7];

                                                                                            END ELSE
                                                                                                IF charges.Description = Y4_Trans_Txt[8] THEN BEGIN
                                                                                                    Y4_Trans_Code[8] := stage_Charge.Code;
                                                                                                    Y4_Trans_Txt[8] := charges.Description;
                                                                                                    Y4S2_Trans_Val[8] := stage_Charge.Amount;
                                                                                                    Y4_Trans_Grand_Total[8] := Y4_Trans_Grand_Total[8] + Y4S2_Trans_Val[8];
                                                                                                    Y4S2_Total := Y4S2_Total + Y4S2_Trans_Val[8];
                                                                                                    Y4_Grand_Total := Y4_Grand_Total + Y4S2_Trans_Val[8];

                                                                                                END ELSE
                                                                                                    IF charges.Description = Y4_Trans_Txt[9] THEN BEGIN
                                                                                                        Y4_Trans_Code[9] := stage_Charge.Code;
                                                                                                        Y4_Trans_Txt[9] := charges.Description;
                                                                                                        Y4S2_Trans_Val[9] := stage_Charge.Amount;
                                                                                                        Y4_Trans_Grand_Total[9] := Y4_Trans_Grand_Total[9] + Y4S2_Trans_Val[9];
                                                                                                        Y4S2_Total := Y4S2_Total + Y4S2_Trans_Val[9];
                                                                                                        Y4_Grand_Total := Y4_Grand_Total + Y4S2_Trans_Val[9];

                                                                                                    END ELSE
                                                                                                        IF charges.Description = Y4_Trans_Txt[10] THEN BEGIN
                                                                                                            Y4_Trans_Code[10] := stage_Charge.Code;
                                                                                                            Y4_Trans_Txt[10] := charges.Description;
                                                                                                            Y4S2_Trans_Val[10] := stage_Charge.Amount;
                                                                                                            Y4_Trans_Grand_Total[10] := Y4_Trans_Grand_Total[10] + Y4S2_Trans_Val[10];
                                                                                                            Y4S2_Total := Y4S2_Total + Y4S2_Trans_Val[10];
                                                                                                            Y4_Grand_Total := Y4_Grand_Total + Y4S2_Trans_Val[10];

                                                                                                        END ELSE
                                                                                                            IF charges.Description = Y4_Trans_Txt[11] THEN BEGIN
                                                                                                                Y4_Trans_Code[11] := stage_Charge.Code;
                                                                                                                Y4_Trans_Txt[11] := charges.Description;
                                                                                                                Y4S2_Trans_Val[11] := stage_Charge.Amount;
                                                                                                                Y4_Trans_Grand_Total[11] := Y4_Trans_Grand_Total[11] + Y4S2_Trans_Val[11];
                                                                                                                Y4S2_Total := Y4S2_Total + Y4S2_Trans_Val[11];
                                                                                                                Y4_Grand_Total := Y4_Grand_Total + Y4S2_Trans_Val[11];

                                                                                                            END ELSE
                                                                                                                IF charges.Description = Y4_Trans_Txt[12] THEN BEGIN
                                                                                                                    Y4_Trans_Code[12] := stage_Charge.Code;
                                                                                                                    Y4_Trans_Txt[12] := charges.Description;
                                                                                                                    Y4S2_Trans_Val[12] := stage_Charge.Amount;
                                                                                                                    Y4_Trans_Grand_Total[12] := Y4_Trans_Grand_Total[12] + Y4S2_Trans_Val[12];
                                                                                                                    Y4S2_Total := Y4S2_Total + Y4S2_Trans_Val[12];
                                                                                                                    Y4_Grand_Total := Y4_Grand_Total + Y4S2_Trans_Val[12];

                                                                                                                END ELSE
                                                                                                                    IF charges.Description = Y4_Trans_Txt[13] THEN BEGIN
                                                                                                                        Y4_Trans_Code[13] := stage_Charge.Code;
                                                                                                                        Y4_Trans_Txt[13] := charges.Description;
                                                                                                                        Y4S2_Trans_Val[13] := stage_Charge.Amount;
                                                                                                                        Y4_Trans_Grand_Total[13] := Y4_Trans_Grand_Total[13] + Y4S2_Trans_Val[13];
                                                                                                                        Y4S2_Total := Y4S2_Total + Y4S2_Trans_Val[13];
                                                                                                                        Y4_Grand_Total := Y4_Grand_Total + Y4S2_Trans_Val[13];
                                                                                                                    END;
                                                                END;//10
                                                        END; // end for Y4S2 Charges Loop (Repeat)1
                                                        UNTIL stage_Charge.NEXT = 0;
                                                    END;//3
                                                        // Fetch Tuition Fees for Y4S2
                                                    FeeByStage.RESET;
                                                    FeeByStage.SETRANGE(FeeByStage."Programme Code", Code);
                                                    FeeByStage.SETRANGE(FeeByStage."Stage Code", 'Y4S2');
                                                    FeeByStage.SETRANGE(FeeByStage."Settlemet Type", Settlement_Type);
                                                    IF FeeByStage.FIND('-') THEN BEGIN //6
                                                        Y4S2_Tuit_Val := FeeByStage."Break Down";
                                                        Y4_Tuit_Total_Val := Y4_Tuit_Total_Val + Y4S2_Tuit_Val;
                                                        Y4S2_Total := Y4S2_Total + Y4S2_Tuit_Val;
                                                        Y4_Grand_Total := Y4_Grand_Total + Y4S2_Tuit_Val;
                                                    END; // 6

                                                END;// 7
                                            END; //5
                                                 //**************************************END Y4 END***********************************************//
                                    END ELSE
                                        IF (COPYSTR(progStages.Code, 1, 2) = 'Y5') THEN BEGIN // Check if the stage is for 5th Years
                                                                                              //clearVariables5();
                                            IF Y5 = '' THEN Y5 := 'ACADEMIC YEAR - 5TH YEAR STUDENTS';


                                            Y5_ItemLabel := 'ITEM';
                                            Y5S1_Tuit_Caption := 'FIRST';
                                            Y5S2_Tuit_Caption := 'SEMESTER';
                                            Y5_Tuit_Total_Caption := '(KES)';
                                            Y5S1_Tuit_Caption2 := 'SECOND';
                                            Y5S2_Tuit_Caption2 := 'SEMESTER';
                                            Y5_Tuit_Total_Caption2 := '(KES)';
                                            Y5S1_Tuit_Caption3 := 'TOTAL PER';
                                            Y5S2_Tuit_Caption3 := 'YEAR';
                                            Y5_Tuit_Total_Caption3 := '(KES)';
                                            Y5_Tuit_txt_lbl1 := 'A. TUITION: ';
                                            Y5_Charges_txt_lbl2 := 'B. OTHER CHARGES: ';
                                            Y5_Tuit_txt := 'to be paid to the University';
                                            Y5_Tuit_txt2 := 'on the registration day';
                                            Y5_Charges_txt := 'To bepaid to the ';
                                            Y5_Charges_txt2 := 'University on the registration day';
                                            Y5_Trans_txt_Footer := 'TOTAL FEE PAYABLE TO CUEA';
                                            /// Fetch Charges and populate here
                                            //********************************************Y5**************************************************//
                                            // Fetch Charges per Stage for 1st Year 1st Sem Here
                                            IF progStages.Code = 'Y5S1' THEN BEGIN //4
                                                stage_Charge.RESET;
                                                stage_Charge.SETRANGE(stage_Charge."Programme Code", Code);
                                                stage_Charge.SETRANGE(stage_Charge."Settlement Type", Settlement_Type);
                                                stage_Charge.SETFILTER(stage_Charge."Stage Code", 'Y5S1');
                                                IF stage_Charge.FIND('-') THEN BEGIN //3
                                                    REPEAT
                                                    BEGIN // Begin for Y5S1 Charges Loop 1
                                                          // Charges for Y5S1 Exists
                                                          //Fetch Name for the charge
                                                        IF charges.GET(stage_Charge.Code) THEN
                                                            IF NOT ((charges.Description) IN [Y5_Trans_Txt[1] .. Y5_Trans_Txt[13]]) THEN BEGIN // Charge Item Has not been Fetched already //2
                                                                                                                                               //
                                                                i5 := COMPRESSARRAY(Y5_Trans_Txt) + 1;
                                                                Y5_Trans_Code[i5] := stage_Charge.Code;
                                                                Y5_Trans_Txt[i5] := charges.Description;
                                                                Y5S1_Trans_Val[i5] := stage_Charge.Amount;
                                                                Y5_Trans_Grand_Total[i5] := Y5_Trans_Grand_Total[i5] + Y5S1_Trans_Val[i5];
                                                                Y5S1_Total := Y5S1_Total + Y5S1_Trans_Val[i5];
                                                                Y5_Grand_Total := Y5_Grand_Total + Y5S1_Trans_Val[i5];
                                                            END; //2
                                                    END; // end for Y5S1 Charges Loop (Repeat)1
                                                    UNTIL stage_Charge.NEXT = 0;
                                                END;//3
                                                    // Fetch Tuition Fees for Y5S1
                                                FeeByStage.RESET;
                                                FeeByStage.SETRANGE(FeeByStage."Programme Code", Code);
                                                FeeByStage.SETRANGE(FeeByStage."Stage Code", 'Y5S1');
                                                FeeByStage.SETRANGE(FeeByStage."Settlemet Type", Settlement_Type);
                                                IF FeeByStage.FIND('-') THEN BEGIN //6
                                                    Y5S1_Tuit_Val := FeeByStage."Break Down";
                                                    Y5_Tuit_Total_Val := Y5_Tuit_Total_Val + Y5S1_Tuit_Val;
                                                    Y5S1_Total := Y5S1_Total + Y5S1_Tuit_Val;
                                                    Y5_Grand_Total := Y5_Grand_Total + Y5S1_Tuit_Val;
                                                END; // 6
                                            END ELSE
                                                IF progStages.Code = 'Y5S2' THEN BEGIN // 4/5
                                                    CLEAR(counts);
                                                    BEGIN // 7
                                                        counts := counts + 1;
                                                        // Fetch Charges per Stage for 1st Year 2nd sem Here
                                                        stage_Charge.RESET;
                                                        stage_Charge.SETRANGE(stage_Charge."Programme Code", Code);
                                                        stage_Charge.SETRANGE(stage_Charge."Settlement Type", Settlement_Type);
                                                        //stage_Charge.setrange(stage_Charge.Code,Y5_Trans_Code[counts]);
                                                        stage_Charge.SETFILTER(stage_Charge."Stage Code", 'Y5S2');
                                                        IF stage_Charge.FIND('-') THEN BEGIN //3
                                                            REPEAT
                                                            BEGIN // Begin for Y5S2 Charges Loop 1
                                                                  // Charges for Y5S2 Exists
                                                                  //Fetch Name for the charge
                                                                  //ERROR(Y5_Trans_Txt[1]+': '+Y5_Trans_Txt[2]);
                                                                IF charges.GET(stage_Charge.Code) THEN
                                                                    //IF NOT ((charges.Description) IN [Y5_Trans_Txt[1]..Y5_Trans_Txt[13]]) THEN BEGIN // Charge Item Has not been Fetched already //2
                                                                    IF NOT (((charges.Description = Y5_Trans_Txt[1]) OR (charges.Description = Y5_Trans_Txt[2])
                                OR (charges.Description = Y5_Trans_Txt[3]) OR (charges.Description = Y5_Trans_Txt[4])
                                OR (charges.Description = Y5_Trans_Txt[5]) OR (charges.Description = Y5_Trans_Txt[6])
                                OR (charges.Description = Y5_Trans_Txt[7]) OR (charges.Description = Y5_Trans_Txt[8])
                                OR (charges.Description = Y5_Trans_Txt[9]) OR (charges.Description = Y5_Trans_Txt[10])
                                OR (charges.Description = Y5_Trans_Txt[11]) OR (charges.Description = Y5_Trans_Txt[12])
                                OR (charges.Description = Y5_Trans_Txt[13]))) THEN BEGIN // Charge Item Has not been Fetched already //2
                                                                                         //
                                                                        i5 := (COMPRESSARRAY(Y5_Trans_Txt)) + 1;
                                                                        Y5_Trans_Code[i5] := stage_Charge.Code;
                                                                        Y5_Trans_Txt[i5] := charges.Description;
                                                                        Y5S2_Trans_Val[i5] := stage_Charge.Amount;
                                                                        Y5_Trans_Grand_Total[i5] := Y5_Trans_Grand_Total[i5] + Y5S2_Trans_Val[i5];
                                                                        Y5S2_Total := Y5S2_Total + Y5S2_Trans_Val[i5];
                                                                        Y5_Grand_Total := Y5_Grand_Total + Y5S2_Trans_Val[i5];
                                                                    END  //2
                                                                    ELSE BEGIN//10 If the Item has notyet been picked
                                                                        IF charges.Description = Y5_Trans_Txt[1] THEN BEGIN
                                                                            Y5_Trans_Code[1] := stage_Charge.Code;
                                                                            Y5_Trans_Txt[1] := charges.Description;
                                                                            Y5S2_Trans_Val[1] := stage_Charge.Amount;
                                                                            Y5_Trans_Grand_Total[1] := Y5_Trans_Grand_Total[1] + Y5S2_Trans_Val[1];
                                                                            Y5S2_Total := Y5S2_Total + Y5S2_Trans_Val[1];
                                                                            Y5_Grand_Total := Y5_Grand_Total + Y5S2_Trans_Val[1];
                                                                        END ELSE
                                                                            IF charges.Description = Y5_Trans_Txt[2] THEN BEGIN
                                                                                Y5_Trans_Code[2] := stage_Charge.Code;
                                                                                Y5_Trans_Txt[2] := charges.Description;
                                                                                Y5S2_Trans_Val[2] := stage_Charge.Amount;
                                                                                Y5_Trans_Grand_Total[2] := Y5_Trans_Grand_Total[2] + Y5S2_Trans_Val[2];
                                                                                Y5S2_Total := Y5S2_Total + Y5S2_Trans_Val[2];
                                                                                Y5_Grand_Total := Y5_Grand_Total + Y5S2_Trans_Val[2];
                                                                            END ELSE
                                                                                IF charges.Description = Y5_Trans_Txt[3] THEN BEGIN
                                                                                    Y5_Trans_Code[3] := stage_Charge.Code;
                                                                                    Y5_Trans_Txt[3] := charges.Description;
                                                                                    Y5S2_Trans_Val[3] := stage_Charge.Amount;
                                                                                    Y5_Trans_Grand_Total[3] := Y5_Trans_Grand_Total[3] + Y5S2_Trans_Val[3];
                                                                                    Y5S2_Total := Y5S2_Total + Y5S2_Trans_Val[3];
                                                                                    Y5_Grand_Total := Y5_Grand_Total + Y5S2_Trans_Val[3];

                                                                                END ELSE
                                                                                    IF charges.Description = Y5_Trans_Txt[4] THEN BEGIN
                                                                                        Y5_Trans_Code[4] := stage_Charge.Code;
                                                                                        Y5_Trans_Txt[4] := charges.Description;
                                                                                        Y5S2_Trans_Val[4] := stage_Charge.Amount;
                                                                                        Y5_Trans_Grand_Total[4] := Y5_Trans_Grand_Total[4] + Y5S2_Trans_Val[4];
                                                                                        Y5S2_Total := Y5S2_Total + Y5S2_Trans_Val[4];
                                                                                        Y5_Grand_Total := Y5_Grand_Total + Y5S2_Trans_Val[4];

                                                                                    END ELSE
                                                                                        IF charges.Description = Y5_Trans_Txt[5] THEN BEGIN
                                                                                            Y5_Trans_Code[5] := stage_Charge.Code;
                                                                                            Y5_Trans_Txt[5] := charges.Description;
                                                                                            Y5S2_Trans_Val[5] := stage_Charge.Amount;
                                                                                            Y5_Trans_Grand_Total[5] := Y5_Trans_Grand_Total[5] + Y5S2_Trans_Val[5];
                                                                                            Y5S2_Total := Y5S2_Total + Y5S2_Trans_Val[5];
                                                                                            Y5_Grand_Total := Y5_Grand_Total + Y5S2_Trans_Val[5];

                                                                                        END ELSE
                                                                                            IF charges.Description = Y5_Trans_Txt[6] THEN BEGIN
                                                                                                Y5_Trans_Code[6] := stage_Charge.Code;
                                                                                                Y5_Trans_Txt[6] := charges.Description;
                                                                                                Y5S2_Trans_Val[6] := stage_Charge.Amount;
                                                                                                Y5_Trans_Grand_Total[6] := Y5_Trans_Grand_Total[6] + Y5S2_Trans_Val[6];
                                                                                                Y5S2_Total := Y5S2_Total + Y5S2_Trans_Val[6];
                                                                                                Y5_Grand_Total := Y5_Grand_Total + Y5S2_Trans_Val[6];

                                                                                            END ELSE
                                                                                                IF charges.Description = Y5_Trans_Txt[7] THEN BEGIN
                                                                                                    Y5_Trans_Code[7] := stage_Charge.Code;
                                                                                                    Y5_Trans_Txt[7] := charges.Description;
                                                                                                    Y5S2_Trans_Val[7] := stage_Charge.Amount;
                                                                                                    Y5_Trans_Grand_Total[7] := Y5_Trans_Grand_Total[7] + Y5S2_Trans_Val[7];
                                                                                                    Y5S2_Total := Y5S2_Total + Y5S2_Trans_Val[7];
                                                                                                    Y5_Grand_Total := Y5_Grand_Total + Y5S2_Trans_Val[7];

                                                                                                END ELSE
                                                                                                    IF charges.Description = Y5_Trans_Txt[8] THEN BEGIN
                                                                                                        Y5_Trans_Code[8] := stage_Charge.Code;
                                                                                                        Y5_Trans_Txt[8] := charges.Description;
                                                                                                        Y5S2_Trans_Val[8] := stage_Charge.Amount;
                                                                                                        Y5_Trans_Grand_Total[8] := Y5_Trans_Grand_Total[8] + Y5S2_Trans_Val[8];
                                                                                                        Y5S2_Total := Y5S2_Total + Y5S2_Trans_Val[8];
                                                                                                        Y5_Grand_Total := Y5_Grand_Total + Y5S2_Trans_Val[8];

                                                                                                    END ELSE
                                                                                                        IF charges.Description = Y5_Trans_Txt[9] THEN BEGIN
                                                                                                            Y5_Trans_Code[9] := stage_Charge.Code;
                                                                                                            Y5_Trans_Txt[9] := charges.Description;
                                                                                                            Y5S2_Trans_Val[9] := stage_Charge.Amount;
                                                                                                            Y5_Trans_Grand_Total[9] := Y5_Trans_Grand_Total[9] + Y5S2_Trans_Val[9];
                                                                                                            Y5S2_Total := Y5S2_Total + Y5S2_Trans_Val[9];
                                                                                                            Y5_Grand_Total := Y5_Grand_Total + Y5S2_Trans_Val[9];

                                                                                                        END ELSE
                                                                                                            IF charges.Description = Y5_Trans_Txt[10] THEN BEGIN
                                                                                                                Y5_Trans_Code[10] := stage_Charge.Code;
                                                                                                                Y5_Trans_Txt[10] := charges.Description;
                                                                                                                Y5S2_Trans_Val[10] := stage_Charge.Amount;
                                                                                                                Y5_Trans_Grand_Total[10] := Y5_Trans_Grand_Total[10] + Y5S2_Trans_Val[10];
                                                                                                                Y5S2_Total := Y5S2_Total + Y5S2_Trans_Val[10];
                                                                                                                Y5_Grand_Total := Y5_Grand_Total + Y5S2_Trans_Val[10];

                                                                                                            END ELSE
                                                                                                                IF charges.Description = Y5_Trans_Txt[11] THEN BEGIN
                                                                                                                    Y5_Trans_Code[11] := stage_Charge.Code;
                                                                                                                    Y5_Trans_Txt[11] := charges.Description;
                                                                                                                    Y5S2_Trans_Val[11] := stage_Charge.Amount;
                                                                                                                    Y5_Trans_Grand_Total[11] := Y5_Trans_Grand_Total[11] + Y5S2_Trans_Val[11];
                                                                                                                    Y5S2_Total := Y5S2_Total + Y5S2_Trans_Val[11];
                                                                                                                    Y5_Grand_Total := Y5_Grand_Total + Y5S2_Trans_Val[11];

                                                                                                                END ELSE
                                                                                                                    IF charges.Description = Y5_Trans_Txt[12] THEN BEGIN
                                                                                                                        Y5_Trans_Code[12] := stage_Charge.Code;
                                                                                                                        Y5_Trans_Txt[12] := charges.Description;
                                                                                                                        Y5S2_Trans_Val[12] := stage_Charge.Amount;
                                                                                                                        Y5_Trans_Grand_Total[12] := Y5_Trans_Grand_Total[12] + Y5S2_Trans_Val[12];
                                                                                                                        Y5S2_Total := Y5S2_Total + Y5S2_Trans_Val[12];
                                                                                                                        Y5_Grand_Total := Y5_Grand_Total + Y5S2_Trans_Val[12];

                                                                                                                    END ELSE
                                                                                                                        IF charges.Description = Y5_Trans_Txt[13] THEN BEGIN
                                                                                                                            Y5_Trans_Code[13] := stage_Charge.Code;
                                                                                                                            Y5_Trans_Txt[13] := charges.Description;
                                                                                                                            Y5S2_Trans_Val[13] := stage_Charge.Amount;
                                                                                                                            Y5_Trans_Grand_Total[13] := Y5_Trans_Grand_Total[13] + Y5S2_Trans_Val[13];
                                                                                                                            Y5S2_Total := Y5S2_Total + Y5S2_Trans_Val[13];
                                                                                                                            Y5_Grand_Total := Y5_Grand_Total + Y5S2_Trans_Val[13];
                                                                                                                        END;
                                                                    END;//10
                                                            END; // end for Y5S2 Charges Loop (Repeat)1
                                                            UNTIL stage_Charge.NEXT = 0;
                                                        END;//3
                                                            // Fetch Tuition Fees for Y5S2
                                                        FeeByStage.RESET;
                                                        FeeByStage.SETRANGE(FeeByStage."Programme Code", Code);
                                                        FeeByStage.SETRANGE(FeeByStage."Stage Code", 'Y5S2');
                                                        FeeByStage.SETRANGE(FeeByStage."Settlemet Type", Settlement_Type);
                                                        IF FeeByStage.FIND('-') THEN BEGIN //6
                                                            Y5S2_Tuit_Val := FeeByStage."Break Down";
                                                            Y5_Tuit_Total_Val := Y5_Tuit_Total_Val + Y5S2_Tuit_Val;
                                                            Y5S2_Total := Y5S2_Total + Y5S2_Tuit_Val;
                                                            Y5_Grand_Total := Y5_Grand_Total + Y5S2_Tuit_Val;
                                                        END; // 6

                                                    END;// 7
                                                END; //5
                                                     //**************************************END Y5 END***********************************************//
                                        END;
                    END;
                    UNTIL progStages.NEXT = 0;
                END;
            end;

            trigger OnPreDataItem()
            begin
                IF (GETFILTER("Settlement Type Filter")) = '' THEN ERROR('The Settlement Type must have a value. \It cannot be zero or empty.');
                Settlement_Type := (GETFILTER("Settlement Type Filter"));
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        IF compInf.GET() THEN
            //Settlement_Type := compInf."Last Settlement Type";
        compInf.CALCFIELDS(compInf.Picture);
    end;

    trigger OnPostReport()
    begin
        IF Settlement_Type <> '' THEN
            IF compInf.GET() THEN BEGIN
                //compInf."Last Settlement Type" := Settlement_Type;
                compInf.MODIFY;
            END;
    end;

    trigger OnPreReport()
    begin
        //  IF Settlement_Type='' THEN ERROR('The Settlement Type must have a value. \It cannot be zero or empty.');
    end;

    var
        compInf: Record 79;
        FacultyName: Code[150];
        Y1: Code[150];
        Y1_ItemLabel: Code[30];
        Y1S1_Tuit_Caption: Code[100];
        Y1S2_Tuit_Caption: Code[100];
        Y1_Tuit_Total_Caption: Code[100];
        Y1S1_Tuit_Caption2: Code[100];
        Y1S2_Tuit_Caption2: Code[100];
        Y1_Tuit_Total_Caption2: Code[100];
        Y1S1_Tuit_Caption3: Code[100];
        Y1S2_Tuit_Caption3: Code[100];
        Y1_Tuit_Total_Caption3: Code[100];
        Y1S1_Tuit_Val: Decimal;
        Y1S2_Tuit_Val: Decimal;
        Y1_Tuit_Total_Val: Decimal;
        Y1_Tuit_txt_lbl1: Code[30];
        Y1_Charges_txt_lbl2: Code[30];
        Y1_Tuit_txt: Text[100];
        Y1_Tuit_txt2: Text[100];
        Y1_Charges_txt: Text[100];
        Y1_Charges_txt2: Text[100];
        Y1_Trans_txt_Footer: Code[100];
        Y1S1_Total: Decimal;
        Y1S2_Total: Decimal;
        Y1_Grand_Total: Decimal;
        Y1_Trans_Txt: array[20] of Text[100];
        Y1S1_Trans_Val: array[20] of Decimal;
        Y1S2_Trans_Val: array[20] of Decimal;
        Y1_Trans_Grand_Total: array[20] of Decimal;
        Y1_Trans_Code: array[20] of Code[100];
        counts: Integer;
        Settlement_Type: Code[30];
        i1: Integer;
        charges: Record 61515;
        stage_Charge: Record 61533;
        progStages: Record 61516;
        FeeByStage: Record 61523;
        "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 2": Integer;
        Y2: Code[150];
        Y2_ItemLabel: Code[30];
        Y2S1_Tuit_Caption: Code[100];
        Y2S2_Tuit_Caption: Code[100];
        Y2_Tuit_Total_Caption: Code[100];
        Y2S1_Tuit_Caption2: Code[100];
        Y2S2_Tuit_Caption2: Code[100];
        Y2_Tuit_Total_Caption2: Code[100];
        Y2S1_Tuit_Caption3: Code[100];
        Y2S2_Tuit_Caption3: Code[100];
        Y2_Tuit_Total_Caption3: Code[100];
        Y2S1_Tuit_Val: Decimal;
        Y2S2_Tuit_Val: Decimal;
        Y2_Tuit_Total_Val: Decimal;
        Y2_Tuit_txt_lbl1: Code[30];
        Y2_Charges_txt_lbl2: Code[30];
        Y2_Tuit_txt: Text[100];
        Y2_Tuit_txt2: Text[100];
        Y2_Charges_txt: Text[100];
        Y2_Charges_txt2: Text[100];
        Y2_Trans_txt_Footer: Code[100];
        Y2S1_Total: Decimal;
        Y2S2_Total: Decimal;
        Y2_Grand_Total: Decimal;
        Y2_Trans_Txt: array[20] of Text[100];
        Y2S1_Trans_Val: array[20] of Decimal;
        Y2S2_Trans_Val: array[20] of Decimal;
        Y2_Trans_Grand_Total: array[20] of Decimal;
        Y2_Trans_Code: array[20] of Code[100];
        i2: Integer;
        "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 3": Integer;
        Y3: Code[150];
        Y3_ItemLabel: Code[30];
        Y3S1_Tuit_Caption: Code[100];
        Y3S2_Tuit_Caption: Code[100];
        Y3_Tuit_Total_Caption: Code[100];
        Y3S1_Tuit_Caption2: Code[100];
        Y3S2_Tuit_Caption2: Code[100];
        Y3_Tuit_Total_Caption2: Code[100];
        Y3S1_Tuit_Caption3: Code[100];
        Y3S2_Tuit_Caption3: Code[100];
        Y3_Tuit_Total_Caption3: Code[100];
        Y3S1_Tuit_Val: Decimal;
        Y3S2_Tuit_Val: Decimal;
        Y3_Tuit_Total_Val: Decimal;
        Y3_Tuit_txt_lbl1: Code[30];
        Y3_Charges_txt_lbl2: Code[30];
        Y3_Tuit_txt: Text[100];
        Y3_Tuit_txt2: Text[100];
        Y3_Charges_txt: Text[100];
        Y3_Charges_txt2: Text[100];
        Y3_Trans_txt_Footer: Code[100];
        Y3S1_Total: Decimal;
        Y3S2_Total: Decimal;
        Y3_Grand_Total: Decimal;
        Y3_Trans_Txt: array[20] of Text[100];
        Y3S1_Trans_Val: array[20] of Decimal;
        Y3S2_Trans_Val: array[20] of Decimal;
        Y3_Trans_Grand_Total: array[20] of Decimal;
        Y3_Trans_Code: array[20] of Code[100];
        i3: Integer;
        "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 4": Integer;
        Y4: Code[150];
        Y4_ItemLabel: Code[30];
        Y4S1_Tuit_Caption: Code[100];
        Y4S2_Tuit_Caption: Code[100];
        Y4_Tuit_Total_Caption: Code[100];
        Y4S1_Tuit_Caption2: Code[100];
        Y4S2_Tuit_Caption2: Code[100];
        Y4_Tuit_Total_Caption2: Code[100];
        Y4S1_Tuit_Caption3: Code[100];
        Y4S2_Tuit_Caption3: Code[100];
        Y4_Tuit_Total_Caption3: Code[100];
        Y4S1_Tuit_Val: Decimal;
        Y4S2_Tuit_Val: Decimal;
        Y4_Tuit_Total_Val: Decimal;
        Y4_Tuit_txt_lbl1: Code[30];
        Y4_Charges_txt_lbl2: Code[30];
        Y4_Tuit_txt: Text[100];
        Y4_Tuit_txt2: Text[100];
        Y4_Charges_txt: Text[100];
        Y4_Charges_txt2: Text[100];
        Y4_Trans_txt_Footer: Code[100];
        Y4S1_Total: Decimal;
        Y4S2_Total: Decimal;
        Y4_Grand_Total: Decimal;
        Y4_Trans_Txt: array[20] of Text[100];
        Y4S1_Trans_Val: array[20] of Decimal;
        Y4S2_Trans_Val: array[20] of Decimal;
        Y4_Trans_Grand_Total: array[20] of Decimal;
        Y4_Trans_Code: array[20] of Code[100];
        i4: Integer;
        "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 5": Integer;
        Y5: Code[150];
        Y5_ItemLabel: Code[30];
        Y5S1_Tuit_Caption: Code[100];
        Y5S2_Tuit_Caption: Code[100];
        Y5_Tuit_Total_Caption: Code[100];
        Y5S1_Tuit_Caption2: Code[100];
        Y5S2_Tuit_Caption2: Code[100];
        Y5_Tuit_Total_Caption2: Code[100];
        Y5S1_Tuit_Caption3: Code[100];
        Y5S2_Tuit_Caption3: Code[100];
        Y5_Tuit_Total_Caption3: Code[100];
        Y5S1_Tuit_Val: Decimal;
        Y5S2_Tuit_Val: Decimal;
        Y5_Tuit_Total_Val: Decimal;
        Y5_Tuit_txt_lbl1: Code[30];
        Y5_Charges_txt_lbl2: Code[30];
        Y5_Tuit_txt: Text[100];
        Y5_Tuit_txt2: Text[100];
        Y5_Charges_txt: Text[100];
        Y5_Charges_txt2: Text[100];
        Y5_Trans_txt_Footer: Code[100];
        Y5S1_Total: Decimal;
        Y5S2_Total: Decimal;
        Y5_Grand_Total: Decimal;
        Y5_Trans_Txt: array[20] of Text[100];
        Y5S1_Trans_Val: array[20] of Decimal;
        Y5S2_Trans_Val: array[20] of Decimal;
        Y5_Trans_Grand_Total: array[20] of Decimal;
        Y5_Trans_Code: array[20] of Code[100];
        i5: Integer;

    local procedure clearVariables1()
    begin
        CLEAR(Y1);
        CLEAR(Y1_ItemLabel);
        CLEAR(Y1S1_Tuit_Caption);
        CLEAR(Y1S2_Tuit_Caption);
        CLEAR(Y1_Tuit_Total_Caption);
        CLEAR(Y1S1_Tuit_Val);
        CLEAR(Y1S2_Tuit_Val);
        CLEAR(Y1_Tuit_Total_Val);
        CLEAR(Y1_Tuit_txt_lbl1);
        CLEAR(Y1_Charges_txt_lbl2);
        CLEAR(Y1_Tuit_txt);
        CLEAR(Y1_Tuit_txt2);
        CLEAR(Y1_Charges_txt);
        CLEAR(Y1_Charges_txt2);
        CLEAR(Y1_Trans_txt_Footer);
        CLEAR(Y1S1_Total);
        CLEAR(Y1S2_Total);
        CLEAR(Y1_Grand_Total);
        CLEAR(Y1_Trans_Txt);
        CLEAR(Y1S1_Trans_Val);
        CLEAR(Y1S2_Trans_Val);
        CLEAR(Y1_Trans_Grand_Total);
        CLEAR(i1);
        CLEAR(Y1S1_Tuit_Caption2);
        CLEAR(Y1S2_Tuit_Caption2);
        CLEAR(Y1_Tuit_Total_Caption2);
        CLEAR(Y1S1_Tuit_Caption3);
        CLEAR(Y1S2_Tuit_Caption3);
        CLEAR(Y1_Tuit_Total_Caption3);
        CLEAR(Y1_Trans_Code);
    end;

    local procedure clearVariables2()
    begin

        CLEAR(Y2);
        CLEAR(Y2_ItemLabel);
        CLEAR(Y2S1_Tuit_Caption);
        CLEAR(Y2S2_Tuit_Caption);
        CLEAR(Y2_Tuit_Total_Caption);
        CLEAR(Y2S1_Tuit_Val);
        CLEAR(Y2S2_Tuit_Val);
        CLEAR(Y2_Tuit_Total_Val);
        CLEAR(Y2_Tuit_txt_lbl1);
        CLEAR(Y2_Charges_txt_lbl2);
        CLEAR(Y2_Tuit_txt);
        CLEAR(Y2_Tuit_txt2);
        CLEAR(Y2_Charges_txt);
        CLEAR(Y2_Charges_txt2);
        CLEAR(Y2_Trans_txt_Footer);
        CLEAR(Y2S1_Total);
        CLEAR(Y2S2_Total);
        CLEAR(Y2_Grand_Total);
        CLEAR(Y2_Trans_Txt);
        CLEAR(Y2S1_Trans_Val);
        CLEAR(Y2S2_Trans_Val);
        CLEAR(Y2_Trans_Grand_Total);
        CLEAR(i2);
        CLEAR(Y2S1_Tuit_Caption2);
        CLEAR(Y2S2_Tuit_Caption2);
        CLEAR(Y2_Tuit_Total_Caption2);
        CLEAR(Y2S1_Tuit_Caption3);
        CLEAR(Y2S2_Tuit_Caption3);
        CLEAR(Y2_Tuit_Total_Caption3);
        CLEAR(Y2_Trans_Code);
    end;

    local procedure clearVariables3()
    begin

        CLEAR(Y3);
        CLEAR(Y3_ItemLabel);
        CLEAR(Y3S1_Tuit_Caption);
        CLEAR(Y3S2_Tuit_Caption);
        CLEAR(Y3_Tuit_Total_Caption);
        CLEAR(Y3S1_Tuit_Val);
        CLEAR(Y3S2_Tuit_Val);
        CLEAR(Y3_Tuit_Total_Val);
        CLEAR(Y3_Tuit_txt_lbl1);
        CLEAR(Y3_Charges_txt_lbl2);
        CLEAR(Y3_Tuit_txt);
        CLEAR(Y3_Tuit_txt2);
        CLEAR(Y3_Charges_txt);
        CLEAR(Y3_Charges_txt2);
        CLEAR(Y3_Trans_txt_Footer);
        CLEAR(Y3S1_Total);
        CLEAR(Y3S2_Total);
        CLEAR(Y3_Grand_Total);
        CLEAR(Y3_Trans_Txt);
        CLEAR(Y3S1_Trans_Val);
        CLEAR(Y3S2_Trans_Val);
        CLEAR(Y3_Trans_Grand_Total);
        CLEAR(i3);
        CLEAR(Y3S1_Tuit_Caption2);
        CLEAR(Y3S2_Tuit_Caption2);
        CLEAR(Y3_Tuit_Total_Caption2);
        CLEAR(Y3S1_Tuit_Caption3);
        CLEAR(Y3S2_Tuit_Caption3);
        CLEAR(Y3_Tuit_Total_Caption3);
        CLEAR(Y3_Trans_Code);
    end;

    local procedure clearVariables4()
    begin

        CLEAR(Y4);
        CLEAR(Y4_ItemLabel);
        CLEAR(Y4S1_Tuit_Caption);
        CLEAR(Y4S2_Tuit_Caption);
        CLEAR(Y4_Tuit_Total_Caption);
        CLEAR(Y4S1_Tuit_Val);
        CLEAR(Y4S2_Tuit_Val);
        CLEAR(Y4_Tuit_Total_Val);
        CLEAR(Y4_Tuit_txt_lbl1);
        CLEAR(Y4_Charges_txt_lbl2);
        CLEAR(Y4_Tuit_txt);
        CLEAR(Y4_Tuit_txt2);
        CLEAR(Y4_Charges_txt);
        CLEAR(Y4_Charges_txt2);
        CLEAR(Y4_Trans_txt_Footer);
        CLEAR(Y4S1_Total);
        CLEAR(Y4S2_Total);
        CLEAR(Y4_Grand_Total);
        CLEAR(Y4_Trans_Txt);
        CLEAR(Y4S1_Trans_Val);
        CLEAR(Y4S2_Trans_Val);
        CLEAR(Y4_Trans_Grand_Total);
        CLEAR(i4);
        CLEAR(Y4S1_Tuit_Caption2);
        CLEAR(Y4S2_Tuit_Caption2);
        CLEAR(Y4_Tuit_Total_Caption2);
        CLEAR(Y4S1_Tuit_Caption3);
        CLEAR(Y4S2_Tuit_Caption3);
        CLEAR(Y4_Tuit_Total_Caption3);
        CLEAR(Y4_Trans_Code);
    end;

    local procedure clearVariables5()
    begin

        CLEAR(Y5);
        CLEAR(Y5_ItemLabel);
        CLEAR(Y5S1_Tuit_Caption);
        CLEAR(Y5S2_Tuit_Caption);
        CLEAR(Y5_Tuit_Total_Caption);
        CLEAR(Y5S1_Tuit_Val);
        CLEAR(Y5S2_Tuit_Val);
        CLEAR(Y5_Tuit_Total_Val);
        CLEAR(Y5_Tuit_txt_lbl1);
        CLEAR(Y5_Charges_txt_lbl2);
        CLEAR(Y5_Tuit_txt);
        CLEAR(Y5_Tuit_txt2);
        CLEAR(Y5_Charges_txt);
        CLEAR(Y5_Charges_txt2);
        CLEAR(Y5_Trans_txt_Footer);
        CLEAR(Y5S1_Total);
        CLEAR(Y5S2_Total);
        CLEAR(Y5_Grand_Total);
        CLEAR(Y5_Trans_Txt);
        CLEAR(Y5S1_Trans_Val);
        CLEAR(Y5S2_Trans_Val);
        CLEAR(Y5_Trans_Grand_Total);
        CLEAR(i5);
        CLEAR(Y5S1_Tuit_Caption2);
        CLEAR(Y5S2_Tuit_Caption2);
        CLEAR(Y5_Tuit_Total_Caption2);
        CLEAR(Y5S1_Tuit_Caption3);
        CLEAR(Y5S2_Tuit_Caption3);
        CLEAR(Y5_Tuit_Total_Caption3);
        CLEAR(Y5_Trans_Code);
    end;
}

