/// <summary>
/// Report Consolidated Marksheet Detaile (ID 51645).
/// </summary>
report 51645 "Consolidated Marksheet Detaile"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/Consolidated Marksheet Detaile.rdl';

    dataset
    {
        dataitem(DataItem2901; 61532)
        {
            DataItemTableView = SORTING("Student No.") ORDER(Ascending) WHERE("Units Taken" = FILTER(> 0),
                                      "Cust Exist" = FILTER(> 0),
                                      Blocked = CONST(0),
                                      "Register for" = CONST(Stage),
                                      Reversed = FILTER(''));
            RequestFilterFields = "Programme Filter", "Stage Filter", "Semester Filter", "Student No.", Session, Semester, "Options Filter";
            column(SemYear; SemYear)
            {
            }
            column(Course_Registration__GETFILTER__Course_Registration___Stage_Filter__; GETFILTER("Stage Filter"))
            {
            }
            column(PName; PName)
            {
            }
            column(Dept; Dept)
            {
            }
            column(FDesc; FDesc)
            {
            }
            column(Logo; CompInf.Picture)
            {
            }
            column(UnitNo; UnitNo)
            {
            }
            column(YearDesc; YearDesc)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
#pragma warning disable AL0667
            column(Page_No_____FORMAT_CurrReport_PAGENO_; 'Page No.  ' + FORMAT(CurrReport.PAGENO))
#pragma warning restore AL0667
            {
            }
            column(Course_Registration__GETFILTER__Course_Registration___Semester_Filter__; GETFILTER("Semester Filter"))
            {
            }
            column(ColumnH_1_; ColumnH[1])
            {
            }
            column(ColumnH_8_; ColumnH[8])
            {
            }
            column(ColumnH_6_; ColumnH[6])
            {
            }
            column(ColumnH_7_; ColumnH[7])
            {
            }
            column(ColumnH_4_; ColumnH[4])
            {
            }
            column(ColumnH_3_; ColumnH[3])
            {
            }
            column(ColumnH_5_; ColumnH[5])
            {
            }
            column(ColumnH_2_; ColumnH[2])
            {
            }
            column(ColumnH_15_; ColumnH[15])
            {
            }
            column(ColumnH_14_; ColumnH[14])
            {
            }
            column(ColumnH_13_; ColumnH[13])
            {
            }
            column(ColumnH_12_; ColumnH[12])
            {
            }
            column(ColumnH_10_; ColumnH[10])
            {
            }
            column(ColumnH_9_; ColumnH[9])
            {
            }
            column(ColumnH_11_; ColumnH[11])
            {
            }
            column(ColumnH_23_; ColumnH[23])
            {
            }
            column(ColumnH_22_; ColumnH[22])
            {
            }
            column(ColumnH_21_; ColumnH[21])
            {
            }
            column(ColumnH_20_; ColumnH[20])
            {
            }
            column(ColumnH_19_; ColumnH[19])
            {
            }
            column(ColumnH_18_; ColumnH[18])
            {
            }
            column(ColumnH_17_; ColumnH[17])
            {
            }
            column(ColumnH_16_; ColumnH[16])
            {
            }
            column(uColumnV_1_; uColumnV[1])
            {

            }
            column(uColumnV_2_; uColumnV[2])
            {

            }
            column(uColumnV_3_; uColumnV[3])
            {

            }
            column(uColumnV_4_; uColumnV[4])
            {

            }
            column(uColumnV_5_; uColumnV[5])
            {

            }
            column(uColumnV_6_; uColumnV[6])
            {

            }
            column(uColumnV_7_; uColumnV[7])
            {

            }
            column(uColumnV_8_; uColumnV[8])
            {

            }
            column(uColumnV_9_; uColumnV[9])
            {

            }
            column(uColumnV_10_; uColumnV[10])
            {

            }
            column(uColumnV_11_; uColumnV[11])
            {

            }
            column(uColumnV_12_; uColumnV[12])
            {

            }
            column(uColumnV_13_; uColumnV[13])
            {

            }
            column(uColumnV_14_; uColumnV[14])
            {

            }
            column(uColumnV_15_; uColumnV[15])
            {

            }
            column(uColumnV_16_; uColumnV[16])
            {

            }
            column(uColumnV_17_; uColumnV[17])
            {

            }
            column(uColumnV_18_; uColumnV[18])
            {

            }
            column(uColumnV_19_; uColumnV[19])
            {

            }
            column(uColumnV_20_; uColumnV[20])
            {

            }
            column(uColumnV_21_; uColumnV[21])
            {

            }
            column(uColumnV_22_; uColumnV[22])
            {

            }
            column(uColumnV_23_; uColumnV[23])
            {

            }
            column(uColumnV_30_; uColumnV[30])
            {

            }
            column(uColumnV_29_; uColumnV[29])
            {

            }
            column(uColumnV_28_; uColumnV[28])
            {

            }
            column(ColumnH_26_; ColumnH[26])
            {
            }
            column(ColumnH_30_; ColumnH[30])
            {
            }
            column(ColumnH_29_; ColumnH[29])
            {
            }
            column(ColumnH_28_; ColumnH[28])
            {
            }
            column(uColumnV_27_; uColumnV[27])
            {

            }
            column(ColumnH_27_; ColumnH[27])
            {
            }
            column(uColumnV_26_; uColumnV[26])
            {

            }
            column(ColumnH_25_; ColumnH[25])
            {
            }
            column(uColumnV_25_; uColumnV[25])
            {

            }
            column(ColumnH_24_; ColumnH[24])
            {
            }
            column(uColumnV_24_; uColumnV[24])
            {

            }
            column(ColumnH_31_; ColumnH[31])
            {
            }
            column(ColumnH_40_; ColumnH[40])
            {
            }
            column(ColumnH_39_; ColumnH[39])
            {
            }
            column(ColumnH_38_; ColumnH[38])
            {
            }
            column(ColumnH_37_; ColumnH[37])
            {
            }
            column(uColumnV_40_; uColumnV[40])
            {

            }
            column(uColumnV_39_; uColumnV[39])
            {

            }
            column(uColumnV_38_; uColumnV[38])
            {

            }
            column(uColumnV_37_; uColumnV[37])
            {

            }
            column(ColumnH_36_; ColumnH[36])
            {
            }
            column(uColumnV_36_; uColumnV[36])
            {

            }
            column(ColumnH_35_; ColumnH[35])
            {
            }
            column(uColumnV_35_; uColumnV[35])
            {

            }
            column(ColumnH_34_; ColumnH[34])
            {
            }
            column(uColumnV_34_; uColumnV[34])
            {

            }
            column(ColumnH_33_; ColumnH[33])
            {
            }
            column(uColumnV_33_; uColumnV[33])
            {

            }
            column(ColumnH_32_; ColumnH[32])
            {
            }
            column(uColumnV_32_; uColumnV[32])
            {

            }
            column(uColumnV_31_; uColumnV[31])
            {

            }
            column(ColumnH_41_; ColumnH[41])
            {
            }
            column(ColumnH_50_; ColumnH[50])
            {
            }
            column(ColumnH_49_; ColumnH[49])
            {
            }
            column(ColumnH_48_; ColumnH[48])
            {
            }
            column(ColumnH_47_; ColumnH[47])
            {
            }
            column(uColumnV_50_; uColumnV[50])
            {

            }
            column(uColumnV_49_; uColumnV[49])
            {

            }
            column(uColumnV_48_; uColumnV[48])
            {

            }
            column(uColumnV_47_; uColumnV[47])
            {

            }
            column(ColumnH_46_; ColumnH[46])
            {
            }
            column(uColumnV_46_; uColumnV[46])
            {

            }
            column(ColumnH_25__Control1102755076; ColumnH[25])
            {
            }
            column(uColumnV_45_; uColumnV[45])
            {

            }
            column(ColumnH_44_; ColumnH[44])
            {
            }
            column(uColumnV_44_; uColumnV[44])
            {

            }
            column(ColumnH_43_; ColumnH[43])
            {
            }
            column(uColumnV_43_; uColumnV[43])
            {

            }
            column(ColumnH_42_; ColumnH[42])
            {
            }
            column(uColumnV_42_; uColumnV[42])
            {

            }
            column(uColumnV_41_; uColumnV[41])
            {

            }
            column(ColumnH_51_; ColumnH[51])
            {
            }
            column(ColumnH_60_; ColumnH[60])
            {
            }
            column(ColumnH_59_; ColumnH[59])
            {
            }
            column(ColumnH_58_; ColumnH[58])
            {
            }
            column(ColumnH_57_; ColumnH[57])
            {
            }
            column(uColumnV_60_; uColumnV[60])
            {

            }
            column(uColumnV_59_; uColumnV[59])
            {

            }
            column(uColumnV_58_; uColumnV[58])
            {

            }
            column(uColumnV_57_; uColumnV[57])
            {

            }
            column(ColumnH_56_; ColumnH[56])
            {
            }
            column(uColumnV_56_; uColumnV[56])
            {

            }
            column(ColumnH_55_; ColumnH[55])
            {
            }
            column(uColumnV_55_; uColumnV[55])
            {

            }
            column(ColumnH_54_; ColumnH[54])
            {
            }
            column(uColumnV_54_; uColumnV[54])
            {

            }
            column(ColumnH_53_; ColumnH[53])
            {
            }
            column(uColumnV_53_; uColumnV[53])
            {

            }
            column(ColumnH_22__Control1102755102; ColumnH[22])
            {
            }
            column(uColumnV_52_; uColumnV[52])
            {

            }
            column(uColumnV_51_; uColumnV[51])
            {

            }
            column(ColumnH_66_; ColumnH[66])
            {
            }
            column(uColumnV_66_; uColumnV[66])
            {

            }
            column(ColumnH_65_; ColumnH[65])
            {
            }
            column(uColumnV_65_; uColumnV[65])
            {

            }
            column(ColumnH_64_; ColumnH[64])
            {
            }
            column(uColumnV_64_; uColumnV[64])
            {

            }
            column(ColumnH_63_; ColumnH[63])
            {
            }
            column(uColumnV_63_; uColumnV[63])
            {

            }
            column(ColumnH_62_; ColumnH[62])
            {
            }
            column(uColumnV_62_; uColumnV[62])
            {

            }
            column(ColumnH_61_; ColumnH[61])
            {
            }
            column(uColumnV_61_; uColumnV[61])
            {

            }
            column(Course_Registration___Student_No___FORMAT__Course_Registration___Marks_Status__; "Student No." + FORMAT("Registered Reason"))
            {
            }
            column(Cust_Name; Cust.Name)
            {
            }
            column(ColumnV_1_; ColumnV[1])
            {

            }
            column(ColumnV_8_; ColumnV[8])
            {

            }
            column(ColumnV_7_; ColumnV[7])
            {

            }
            column(ColumnV_6_; ColumnV[6])
            {

            }
            column(ColumnV_5_; ColumnV[5])
            {

            }
            column(ColumnV_4_; ColumnV[4])
            {

            }
            column(ColumnV_3_; ColumnV[3])
            {

            }
            column(ColumnV_2_; ColumnV[2])
            {

            }
            column(ColumnV_14_; ColumnV[14])
            {

            }
            column(ColumnV_13_; ColumnV[13])
            {

            }
            column(ColumnV_12_; ColumnV[12])
            {

            }
            column(ColumnV_11_; ColumnV[11])
            {

            }
            column(ColumnV_10_; ColumnV[10])
            {

            }
            column(ColumnV_9_; ColumnV[9])
            {

            }
            column(ColumnV_23_; ColumnV[23])
            {

            }
            column(ColumnV_22_; ColumnV[22])
            {

            }
            column(ColumnV_21_; ColumnV[21])
            {

            }
            column(ColumnV_20_; ColumnV[20])
            {

            }
            column(ColumnV_19_; ColumnV[19])
            {

            }
            column(ColumnV_18_; ColumnV[18])
            {

            }
            column(ColumnV_17_; ColumnV[17])
            {

            }
            column(ColumnV_16_; ColumnV[16])
            {

            }
            column(ColumnV_15_; ColumnV[15])
            {

            }
            column(SCount; SCount)
            {
            }
            column(ColumnV_30_; ColumnV[30])
            {

            }
            column(ColumnV_29_; ColumnV[29])
            {

            }
            column(ColumnV_28_; ColumnV[28])
            {

            }
            column(ColumnV_27_; ColumnV[27])
            {

            }
            column(ColumnV_26_; ColumnV[26])
            {

            }
            column(ColumnV_25_; ColumnV[25])
            {

            }
            column(ColumnV_24_; ColumnV[24])
            {

            }
            column(ColumnV_60_; ColumnV[60])
            {

            }
            column(ColumnV_59_; ColumnV[59])
            {

            }
            column(ColumnV_58_; ColumnV[58])
            {

            }
            column(ColumnV_57_; ColumnV[57])
            {

            }
            column(ColumnV_56_; ColumnV[56])
            {

            }
            column(ColumnV_55_; ColumnV[55])
            {

            }
            column(ColumnV_54_; ColumnV[54])
            {

            }
            column(ColumnV_53_; ColumnV[53])
            {

            }
            column(ColumnV_52_; ColumnV[52])
            {

            }
            column(ColumnV_51_; ColumnV[51])
            {

            }
            column(ColumnV_50_; ColumnV[50])
            {

            }
            column(ColumnV_49_; ColumnV[49])
            {

            }
            column(ColumnV_48_; ColumnV[48])
            {

            }
            column(ColumnV_47_; ColumnV[47])
            {

            }
            column(ColumnV_46_; ColumnV[46])
            {

            }
            column(ColumnV_45_; ColumnV[45])
            {

            }
            column(ColumnV_44_; ColumnV[44])
            {

            }
            column(ColumnV_43_; ColumnV[43])
            {

            }
            column(ColumnV_42_; ColumnV[42])
            {

            }
            column(ColumnV_41_; ColumnV[41])
            {

            }
            column(ColumnV_40_; ColumnV[40])
            {

            }
            column(ColumnV_39_; ColumnV[39])
            {

            }
            column(ColumnV_38_; ColumnV[38])
            {

            }
            column(ColumnV_37_; ColumnV[37])
            {

            }
            column(ColumnV_36_; ColumnV[36])
            {

            }
            column(ColumnV_35_; ColumnV[35])
            {

            }
            column(ColumnV_34_; ColumnV[34])
            {

            }
            column(ColumnV_33_; ColumnV[33])
            {

            }
            column(ColumnV_32_; ColumnV[32])
            {

            }
            column(ColumnV_31_; ColumnV[31])
            {

            }
            column(ColumnV_65_; ColumnV[65])
            {

            }
            column(ColumnV_64_; ColumnV[64])
            {

            }
            column(ColumnV_63_; ColumnV[63])
            {

            }
            column(ColumnV_62_; ColumnV[62])
            {

            }
            column(ColumnV_61_; ColumnV[61])
            {

            }
            column(ColumnV_66_; ColumnV[66])
            {

            }
            column(ColumnUN_24_; ColumnUN[24])
            {

            }
            column(ColumnUN_23_; ColumnUN[23])
            {

            }
            column(ColumnUN_21_; ColumnUN[21])
            {

            }
            column(ColumnUN_22_; ColumnUN[22])
            {

            }
            column(ColumnUN_19_; ColumnUN[19])
            {

            }
            column(ColumnUN_20_; ColumnUN[20])
            {

            }
            column(ColumnUN_18_; ColumnUN[18])
            {

            }
            column(ColumnUN_17_; ColumnUN[17])
            {

            }
            column(ColumnUN_12_; ColumnUN[12])
            {

            }
            column(ColumnUN_11_; ColumnUN[11])
            {

            }
            column(ColumnUN_10_; ColumnUN[10])
            {

            }
            column(ColumnUN_9_; ColumnUN[9])
            {

            }
            column(ColumnUN_16_; ColumnUN[16])
            {

            }
            column(ColumnUN_15_; ColumnUN[15])
            {

            }
            column(ColumnUN_14_; ColumnUN[14])
            {

            }
            column(ColumnUN_13_; ColumnUN[13])
            {

            }
            column(ColumnUN_1_; ColumnUN[1])
            {

            }
            column(ColumnUN_2_; ColumnUN[2])
            {

            }
            column(ColumnUN_4_; ColumnUN[4])
            {

            }
            column(ColumnUN_3_; ColumnUN[3])
            {

            }
            column(ColumnUN_6_; ColumnUN[6])
            {

            }
            column(ColumnUN_5_; ColumnUN[5])
            {

            }
            column(ColumnUN_7_; ColumnUN[7])
            {

            }
            column(ColumnUN_8_; ColumnUN[8])
            {

            }
            column(GenSetup__Cons__Marksheet_Key2_; GenSetup."Cons. Marksheet Key2")
            {

            }
            column(GenSetup__Cons__Marksheet_Key1_; GenSetup."Cons. Marksheet Key1")
            {

            }
            column(Dean___FDesc; 'Dean ' + FDesc)
            {
            }
            column(TReg; TReg)
            {
            }
            column(SMM_1_; SMM[1])
            {
            }
            column(ColumnVA_1_; ColumnVA[1])
            {

            }
            column(ColumnVA_2_; ColumnVA[2])
            {

            }
            column(ColumnVA_3_; ColumnVA[3])
            {

            }
            column(ColumnVA_4_; ColumnVA[4])
            {

            }
            column(ColumnVA_5_; ColumnVA[5])
            {

            }
            column(ColumnVA_6_; ColumnVA[6])
            {

            }
            column(ColumnVA_7_; ColumnVA[7])
            {

            }
            column(ColumnVA_8_; ColumnVA[8])
            {

            }
            column(ColumnVA_9_; ColumnVA[9])
            {

            }
            column(ColumnVA_10_; ColumnVA[10])
            {

            }
            column(ColumnVA_11_; ColumnVA[11])
            {

            }
            column(ColumnVA_12_; ColumnVA[12])
            {

            }
            column(ColumnVA_13_; ColumnVA[13])
            {

            }
            column(ColumnVA_14_; ColumnVA[14])
            {

            }
            column(ColumnVA_15_; ColumnVA[15])
            {

            }
            column(ColumnVA_16_; ColumnVA[16])
            {

            }
            column(ColumnVA_17_; ColumnVA[17])
            {

            }
            column(ColumnVA_18_; ColumnVA[18])
            {

            }
            column(ColumnVA_19_; ColumnVA[19])
            {

            }
            column(ColumnVA_20_; ColumnVA[20])
            {

            }
            column(ColumnVA_21_; ColumnVA[21])
            {

            }
            column(ColumnVA_22_; ColumnVA[22])
            {

            }
            column(ColumnVA_23_; ColumnVA[23])
            {

            }
            column(ColumnVA_24_; ColumnVA[24])
            {

            }
            column(ColumnVA_25_; ColumnVA[25])
            {

            }
            column(ColumnVA_26_; ColumnVA[26])
            {

            }
            column(ColumnVA_27_; ColumnVA[27])
            {

            }
            column(ColumnVA_28_; ColumnVA[28])
            {

            }
            column(ColumnVA_29_; ColumnVA[29])
            {

            }
            column(ColumnVA_30_; ColumnVA[30])
            {

            }
            column(ColumnVA_31_; ColumnVA[31])
            {

            }
            column(ColumnVA_32_; ColumnVA[32])
            {

            }
            column(ColumnVA_33_; ColumnVA[33])
            {

            }
            column(ColumnVA_34_; ColumnVA[34])
            {

            }
            column(ColumnVA_35_; ColumnVA[35])
            {

            }
            column(ColumnVA_36_; ColumnVA[36])
            {

            }
            column(ColumnVA_37_; ColumnVA[37])
            {

            }
            column(ColumnVA_38_; ColumnVA[38])
            {

            }
            column(ColumnVA_39_; ColumnVA[39])
            {

            }
            column(ColumnVA_40_; ColumnVA[40])
            {

            }
            column(ColumnVA_41_; ColumnVA[41])
            {

            }
            column(ColumnVA_42_; ColumnVA[42])
            {

            }
            column(ColumnVA_43_; ColumnVA[43])
            {

            }
            column(ColumnVA_44_; ColumnVA[44])
            {

            }
            column(ColumnVA_45_; ColumnVA[45])
            {

            }
            column(ColumnVA_46_; ColumnVA[46])
            {

            }
            column(ColumnVA_47_; ColumnVA[47])
            {

            }
            column(ColumnVA_48_; ColumnVA[48])
            {

            }
            column(ColumnVA_49_; ColumnVA[49])
            {

            }
            column(ColumnVA_50_; ColumnVA[50])
            {

            }
            column(ColumnVA_51_; ColumnVA[51])
            {

            }
            column(ColumnVA_52_; ColumnVA[52])
            {

            }
            column(ColumnVA_53_; ColumnVA[53])
            {

            }
            column(ColumnVA_54_; ColumnVA[54])
            {

            }
            column(ColumnVA_55_; ColumnVA[55])
            {

            }
            column(ColumnVA_56_; ColumnVA[56])
            {

            }
            column(ColumnVA_57_; ColumnVA[57])
            {

            }
            column(ColumnVA_58_; ColumnVA[58])
            {

            }
            column(ColumnVA_59_; ColumnVA[59])
            {

            }
            column(ColumnVA_60_; ColumnVA[60])
            {

            }
            column(ColumnVA_61_; ColumnVA[61])
            {

            }
            column(ColumnVA_62_; ColumnVA[62])
            {

            }
            column(ColumnVA_63_; ColumnVA[63])
            {

            }
            column(ColumnVA_64_; ColumnVA[64])
            {

            }
            column(ColumnVA_65_; ColumnVA[65])
            {

            }
            column(ColumnVA_66_; ColumnVA[66])
            {

            }
            column(ColumnVM_1_; ColumnVM[1])
            {

            }
            column(ColumnVM_2_; ColumnVM[2])
            {

            }
            column(ColumnVM_3_; ColumnVM[3])
            {

            }
            column(ColumnVM_4_; ColumnVM[4])
            {

            }
            column(ColumnVM_5_; ColumnVM[5])
            {

            }
            column(ColumnVM_6_; ColumnVM[6])
            {

            }
            column(ColumnVM_7_; ColumnVM[7])
            {

            }
            column(ColumnVM_8_; ColumnVM[8])
            {

            }
            column(ColumnVM_9_; ColumnVM[9])
            {

            }
            column(ColumnVM_10_; ColumnVM[10])
            {

            }
            column(ColumnVM_11_; ColumnVM[11])
            {

            }
            column(ColumnVM_12_; ColumnVM[12])
            {

            }
            column(ColumnVM_13_; ColumnVM[13])
            {

            }
            column(ColumnVM_14_; ColumnVM[14])
            {

            }
            column(ColumnVM_15_; ColumnVM[15])
            {

            }
            column(ColumnVM_16_; ColumnVM[16])
            {

            }
            column(ColumnVM_17_; ColumnVM[17])
            {

            }
            column(ColumnVM_18_; ColumnVM[18])
            {

            }
            column(ColumnVM_19_; ColumnVM[19])
            {

            }
            column(ColumnVM_20_; ColumnVM[20])
            {

            }
            column(ColumnVM_21_; ColumnVM[21])
            {

            }
            column(ColumnVM_22_; ColumnVM[22])
            {

            }
            column(ColumnVM_23_; ColumnVM[23])
            {

            }
            column(ColumnVM_24_; ColumnVM[24])
            {

            }
            column(ColumnVM_25_; ColumnVM[25])
            {

            }
            column(ColumnVM_26_; ColumnVM[26])
            {

            }
            column(ColumnVM_27_; ColumnVM[27])
            {

            }
            column(ColumnVM_28_; ColumnVM[28])
            {

            }
            column(ColumnVM_29_; ColumnVM[29])
            {

            }
            column(ColumnVM_30_; ColumnVM[30])
            {

            }
            column(ColumnVM_31_; ColumnVM[31])
            {

            }
            column(ColumnVM_32_; ColumnVM[32])
            {

            }
            column(ColumnVM_33_; ColumnVM[33])
            {

            }
            column(ColumnVM_34_; ColumnVM[34])
            {

            }
            column(ColumnVM_35_; ColumnVM[35])
            {

            }
            column(ColumnVM_36_; ColumnVM[36])
            {

            }
            column(ColumnVM_37_; ColumnVM[37])
            {

            }
            column(ColumnVM_38_; ColumnVM[38])
            {

            }
            column(ColumnVM_39_; ColumnVM[39])
            {

            }
            column(ColumnVM_40_; ColumnVM[40])
            {

            }
            column(ColumnVM_41_; ColumnVM[41])
            {

            }
            column(ColumnVM_42_; ColumnVM[42])
            {

            }
            column(ColumnVM_43_; ColumnVM[43])
            {

            }
            column(ColumnVM_44_; ColumnVM[44])
            {

            }
            column(ColumnVM_45_; ColumnVM[45])
            {

            }
            column(ColumnVM_46_; ColumnVM[46])
            {

            }
            column(ColumnVM_47_; ColumnVM[47])
            {

            }
            column(ColumnVM_48_; ColumnVM[48])
            {

            }
            column(ColumnVM_49_; ColumnVM[49])
            {

            }
            column(ColumnVM_50_; ColumnVM[50])
            {

            }
            column(ColumnVM_51_; ColumnVM[51])
            {

            }
            column(ColumnVM_52_; ColumnVM[52])
            {

            }
            column(ColumnVM_53_; ColumnVM[53])
            {

            }
            column(ColumnVM_54_; ColumnVM[54])
            {

            }
            column(ColumnVM_55_; ColumnVM[55])
            {

            }
            column(ColumnVM_56_; ColumnVM[56])
            {

            }
            column(ColumnVM_57_; ColumnVM[57])
            {

            }
            column(ColumnVM_58_; ColumnVM[58])
            {

            }
            column(ColumnVM_59_; ColumnVM[59])
            {

            }
            column(ColumnVM_60_; ColumnVM[60])
            {

            }
            column(ColumnVM_61_; ColumnVM[61])
            {

            }
            column(ColumnVM_62_; ColumnVM[62])
            {

            }
            column(ColumnVM_63_; ColumnVM[63])
            {

            }
            column(ColumnVM_64_; ColumnVM[64])
            {

            }
            column(ColumnVM_65_; ColumnVM[65])
            {

            }
            column(ColumnVM_66_; ColumnVM[66])
            {

            }
            column(ColumnVX_1_; ColumnVX[1])
            {

            }
            column(ColumnVX_2_; ColumnVX[2])
            {

            }
            column(ColumnVX_3_; ColumnVX[3])
            {

            }
            column(ColumnVX_4_; ColumnVX[4])
            {

            }
            column(ColumnVX_5_; ColumnVX[5])
            {

            }
            column(ColumnVX_6_; ColumnVX[6])
            {

            }
            column(ColumnVX_7_; ColumnVX[7])
            {

            }
            column(ColumnVX_8_; ColumnVX[8])
            {

            }
            column(ColumnVX_9_; ColumnVX[9])
            {

            }
            column(ColumnVX_10_; ColumnVX[10])
            {

            }
            column(ColumnVX_11_; ColumnVX[11])
            {

            }
            column(ColumnVX_12_; ColumnVX[12])
            {

            }
            column(ColumnVX_13_; ColumnVX[13])
            {

            }
            column(ColumnVX_14_; ColumnVX[14])
            {

            }
            column(ColumnVX_15_; ColumnVX[15])
            {

            }
            column(ColumnVX_16_; ColumnVX[16])
            {

            }
            column(ColumnVX_17_; ColumnVX[17])
            {

            }
            column(ColumnVX_18_; ColumnVX[18])
            {

            }
            column(ColumnVX_19_; ColumnVX[19])
            {

            }
            column(ColumnVX_20_; ColumnVX[20])
            {

            }
            column(ColumnVX_21_; ColumnVX[21])
            {

            }
            column(ColumnVX_22_; ColumnVX[22])
            {

            }
            column(ColumnVX_23_; ColumnVX[23])
            {

            }
            column(ColumnVX_24_; ColumnVX[24])
            {

            }
            column(ColumnVX_25_; ColumnVX[25])
            {

            }
            column(ColumnVX_26_; ColumnVX[26])
            {

            }
            column(ColumnVX_27_; ColumnVX[27])
            {

            }
            column(ColumnVX_28_; ColumnVX[28])
            {

            }
            column(ColumnVX_29_; ColumnVX[29])
            {

            }
            column(ColumnVX_30_; ColumnVX[30])
            {

            }
            column(ColumnVX_31_; ColumnVX[31])
            {

            }
            column(ColumnVX_32_; ColumnVX[32])
            {

            }
            column(ColumnVX_33_; ColumnVX[33])
            {

            }
            column(ColumnVX_34_; ColumnVX[34])
            {

            }
            column(ColumnVX_35_; ColumnVX[35])
            {

            }
            column(ColumnVX_36_; ColumnVX[36])
            {

            }
            column(ColumnVX_37_; ColumnVX[37])
            {

            }
            column(ColumnVX_38_; ColumnVX[38])
            {

            }
            column(ColumnVX_39_; ColumnVX[39])
            {

            }
            column(ColumnVX_40_; ColumnVX[40])
            {

            }
            column(ColumnVX_41_; ColumnVX[41])
            {

            }
            column(ColumnVX_42_; ColumnVX[42])
            {

            }
            column(ColumnVX_43_; ColumnVX[43])
            {

            }
            column(ColumnVX_44_; ColumnVX[44])
            {

            }
            column(ColumnVX_45_; ColumnVX[45])
            {

            }
            column(ColumnVX_46_; ColumnVX[46])
            {

            }
            column(ColumnVX_47_; ColumnVX[47])
            {

            }
            column(ColumnVX_48_; ColumnVX[48])
            {

            }
            column(ColumnVX_49_; ColumnVX[49])
            {

            }
            column(ColumnVX_50_; ColumnVX[50])
            {

            }
            column(ColumnVX_51_; ColumnVX[51])
            {

            }
            column(ColumnVX_52_; ColumnVX[52])
            {

            }
            column(ColumnVX_53_; ColumnVX[53])
            {

            }
            column(ColumnVX_54_; ColumnVX[54])
            {

            }
            column(ColumnVX_55_; ColumnVX[55])
            {

            }
            column(ColumnVX_56_; ColumnVX[56])
            {

            }
            column(ColumnVX_57_; ColumnVX[57])
            {

            }
            column(ColumnVX_58_; ColumnVX[58])
            {

            }
            column(ColumnVX_59_; ColumnVX[59])
            {

            }
            column(ColumnVX_60_; ColumnVX[60])
            {

            }
            column(ColumnVX_61_; ColumnVX[61])
            {

            }
            column(ColumnVX_62_; ColumnVX[62])
            {

            }
            column(ColumnVX_63_; ColumnVX[63])
            {

            }
            column(ColumnVX_64_; ColumnVX[64])
            {

            }
            column(ColumnVX_65_; ColumnVX[65])
            {

            }
            column(ColumnVX_66_; ColumnVX[66])
            {

            }
            column(ColumnUN_24__Control1102755385; ColumnUN[24])
            {

            }
            column(ColumnUN_23__Control1102755386; ColumnUN[23])
            {

            }
            column(ColumnUN_21__Control1102755387; ColumnUN[21])
            {

            }
            column(ColumnUN_22__Control1102755388; ColumnUN[22])
            {

            }
            column(ColumnUN_19__Control1102755389; ColumnUN[19])
            {

            }
            column(ColumnUN_20__Control1102755390; ColumnUN[20])
            {

            }
            column(ColumnUN_18__Control1102755391; ColumnUN[18])
            {

            }
            column(ColumnUN_17__Control1102755392; ColumnUN[17])
            {

            }
            column(ColumnUN_12__Control1102755393; ColumnUN[12])
            {

            }
            column(ColumnUN_11__Control1102755394; ColumnUN[11])
            {

            }
            column(ColumnUN_10__Control1102755395; ColumnUN[10])
            {

            }
            column(ColumnUN_9__Control1102755396; ColumnUN[9])
            {

            }
            column(ColumnUN_16__Control1102755397; ColumnUN[16])
            {

            }
            column(ColumnUN_15__Control1102755398; ColumnUN[15])
            {

            }
            column(ColumnUN_14__Control1102755399; ColumnUN[14])
            {

            }
            column(ColumnUN_13__Control1102755400; ColumnUN[13])
            {

            }
            column(ColumnUN_1__Control1102755401; ColumnUN[1])
            {

            }
            column(ColumnUN_2__Control1102755402; ColumnUN[2])
            {

            }
            column(ColumnUN_4__Control1102755403; ColumnUN[4])
            {

            }
            column(ColumnUN_3__Control1102755404; ColumnUN[3])
            {

            }
            column(ColumnUN_6__Control1102755405; ColumnUN[6])
            {

            }
            column(ColumnUN_5__Control1102755406; ColumnUN[5])
            {

            }
            column(ColumnUN_7__Control1102755407; ColumnUN[7])
            {

            }
            column(ColumnUN_8__Control1102755408; ColumnUN[8])
            {

            }
            column(ColumnSD_1_; ColumnSD[1])
            {

            }
            column(ColumnSD_2_; ColumnSD[2])
            {

            }
            column(ColumnSD_3_; ColumnSD[3])
            {

            }
            column(ColumnSD_4_; ColumnSD[4])
            {

            }
            column(ColumnSD_5_; ColumnSD[5])
            {

            }
            column(ColumnSD_6_; ColumnSD[6])
            {

            }
            column(ColumnSD_7_; ColumnSD[7])
            {

            }
            column(ColumnSD_8_; ColumnSD[8])
            {

            }
            column(ColumnSD_9_; ColumnSD[9])
            {

            }
            column(ColumnSD_10_; ColumnSD[10])
            {

            }
            column(ColumnSD_11_; ColumnSD[11])
            {

            }
            column(ColumnSD_12_; ColumnSD[12])
            {

            }
            column(ColumnSD_13_; ColumnSD[13])
            {

            }
            column(ColumnSD_14_; ColumnSD[14])
            {

            }
            column(ColumnSD_15_; ColumnSD[15])
            {

            }
            column(ColumnSD_16_; ColumnSD[16])
            {

            }
            column(ColumnSD_17_; ColumnSD[17])
            {

            }
            column(ColumnSD_18_; ColumnSD[18])
            {

            }
            column(ColumnSD_19_; ColumnSD[19])
            {

            }
            column(ColumnSD_20_; ColumnSD[20])
            {

            }
            column(ColumnSD_21_; ColumnSD[21])
            {

            }
            column(ColumnSD_22_; ColumnSD[22])
            {

            }
            column(ColumnSD_23_; ColumnSD[23])
            {

            }
            column(ColumnSD_24_; ColumnSD[24])
            {

            }
            column(ColumnSD_25_; ColumnSD[25])
            {

            }
            column(ColumnSD_26_; ColumnSD[26])
            {

            }
            column(ColumnSD_27_; ColumnSD[27])
            {

            }
            column(ColumnSD_28_; ColumnSD[28])
            {

            }
            column(ColumnSD_29_; ColumnSD[29])
            {

            }
            column(ColumnSD_30_; ColumnSD[30])
            {

            }
            column(ColumnSD_31_; ColumnSD[31])
            {

            }
            column(ColumnSD_32_; ColumnSD[32])
            {

            }
            column(ColumnSD_33_; ColumnSD[33])
            {

            }
            column(ColumnSD_34_; ColumnSD[34])
            {

            }
            column(ColumnSD_35_; ColumnSD[35])
            {

            }
            column(ColumnSD_36_; ColumnSD[36])
            {

            }
            column(ColumnSD_37_; ColumnSD[37])
            {

            }
            column(ColumnSD_38_; ColumnSD[38])
            {

            }
            column(ColumnSD_39_; ColumnSD[39])
            {

            }
            column(ColumnSD_40_; ColumnSD[40])
            {

            }
            column(ColumnSD_41_; ColumnSD[41])
            {

            }
            column(ColumnSD_42_; ColumnSD[42])
            {

            }
            column(ColumnSD_43_; ColumnSD[43])
            {

            }
            column(ColumnSD_44_; ColumnSD[44])
            {

            }
            column(ColumnSD_45_; ColumnSD[45])
            {

            }
            column(ColumnSD_46_; ColumnSD[46])
            {

            }
            column(ColumnSD_47_; ColumnSD[47])
            {

            }
            column(ColumnSD_48_; ColumnSD[48])
            {

            }
            column(ColumnSD_49_; ColumnSD[49])
            {

            }
            column(ColumnSD_50_; ColumnSD[50])
            {

            }
            column(ColumnSD_51_; ColumnSD[51])
            {

            }
            column(ColumnSD_52_; ColumnSD[52])
            {

            }
            column(ColumnSD_53_; ColumnSD[53])
            {

            }
            column(ColumnSD_54_; ColumnSD[54])
            {

            }
            column(ColumnSD_55_; ColumnSD[55])
            {

            }
            column(ColumnSD_56_; ColumnSD[56])
            {

            }
            column(ColumnSD_57_; ColumnSD[57])
            {

            }
            column(ColumnSD_58_; ColumnSD[58])
            {

            }
            column(ColumnSD_59_; ColumnSD[59])
            {

            }
            column(ColumnSD_60_; ColumnSD[60])
            {

            }
            column(ColumnSD_61_; ColumnSD[61])
            {

            }
            column(ColumnSD_62_; ColumnSD[62])
            {

            }
            column(ColumnSD_63_; ColumnSD[63])
            {

            }
            column(ColumnSD_64_; ColumnSD[64])
            {

            }
            column(ColumnSD_65_; ColumnSD[65])
            {

            }
            column(ColumnSD_66_; ColumnSD[66])
            {

            }
            column(GenSetup__Cons__Marksheet_Key1__Control1102755442; GenSetup."Cons. Marksheet Key1")
            {

            }
            column(GenSetup__Cons__Marksheet_Key2__Control1102755443; GenSetup."Cons. Marksheet Key2")
            {

            }
            column(SMM_2_; SMM[2])
            {
            }
            column(SMM_4_; SMM[4])
            {
            }
            column(SMM_3_; SMM[3])
            {
            }
            column(SMM_6_; SMM[6])
            {
            }
            column(SMM_5_; SMM[5])
            {
            }
            column(SMM_8_; SMM[8])
            {
            }
            column(SMM_7_; SMM[7])
            {
            }
            column(SMM_10_; SMM[10])
            {
            }
            column(SMM_9_; SMM[9])
            {
            }
            column(Dean___FDesc_Control1102755003; 'Dean ' + FDesc)
            {
            }
            column(School_Caption; School_CaptionLbl)
            {
            }
            column(Department_Caption; Department_CaptionLbl)
            {
            }
            column(Programme_of_Study_Caption; Programme_of_Study_CaptionLbl)
            {
            }
            column(Stage_Caption; Stage_CaptionLbl)
            {
            }
            column(Academic_Year_Caption; Academic_Year_CaptionLbl)
            {
            }
            column(Consolidated_MarksheetCaption; Consolidated_MarksheetCaptionLbl)
            {
            }
            column(Semester_Caption; Semester_CaptionLbl)
            {
            }
            column(Registration_No_Caption; Registration_No_CaptionLbl)
            {
            }
            column(NamesCaption; NamesCaptionLbl)
            {
            }
            column(UNITS__Caption; UNITS__CaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(Units_Key_Caption; Units_Key_CaptionLbl)
            {
            }
            column(Approved_by_the_Departmental_Board_of_ExaminersCaption; Approved_by_the_Departmental_Board_of_ExaminersCaptionLbl)
            {
            }
            column(Approved_by_the_School_Board_of_ExaminersCaption; Approved_by_the_School_Board_of_ExaminersCaptionLbl)
            {
            }
            column(Signed_______________________________________Caption; Signed_______________________________________CaptionLbl)
            {
            }
            column(Signed_______________________________________Caption_Control1102755449; Signed_______________________________________Caption_Control1102755449Lbl)
            {
            }
            column(Signed_______________________________________Caption_Control1102755450; Signed_______________________________________Caption_Control1102755450Lbl)
            {
            }
            column(Approved_by_DeKUT_SenateCaption; Approved_by_DeKUT_SenateCaptionLbl)
            {
            }
            column(Chairperson_of_DepartmentCaption; Chairperson_of_DepartmentCaptionLbl)
            {
            }
            column(AG_VC_DeKUTCaption; AG_VC_DeKUTCaptionLbl)
            {
            }
            column(Guide_on_Remarks_Caption; Guide_on_Remarks_CaptionLbl)
            {
            }
            column(Guide_on_remarks_Caption_Control1102760087; Guide_on_remarks_Caption_Control1102760087Lbl)
            {
            }
            column(Total_Reg_Caption; Total_Reg_CaptionLbl)
            {
            }
            column(Mean_ScoreCaption; Mean_ScoreCaptionLbl)
            {
            }
            column(Maximum_ScoreCaption; Maximum_ScoreCaptionLbl)
            {
            }
            column(Minimum_ScoreCaption; Minimum_ScoreCaptionLbl)
            {
            }
            column(Units_Key_Caption_Control1102755384; Units_Key_Caption_Control1102755384Lbl)
            {
            }
            column(Approved_by_the_Departmental_Board_of_ExaminersCaption_Control1000000009; Approved_by_the_Departmental_Board_of_ExaminersCaption_Control1000000009Lbl)
            {
            }
            column(Approved_by_the_School_Board_of_ExaminersCaption_Control1000000010; Approved_by_the_School_Board_of_ExaminersCaption_Control1000000010Lbl)
            {
            }
            column(Signed_______________________________________Caption_Control1000000011; Signed_______________________________________Caption_Control1000000011Lbl)
            {
            }
            column(Signed_______________________________________Caption_Control1000000012; Signed_______________________________________Caption_Control1000000012Lbl)
            {
            }
            column(Signed_______________________________________Caption_Control1000000013; Signed_______________________________________Caption_Control1000000013Lbl)
            {
            }
            column(Approved_by_DeKUT_SenateCaption_Control1000000014; Approved_by_DeKUT_SenateCaption_Control1000000014Lbl)
            {
            }
            column(Chairperson_of_DepartmentCaption_Control1000000015; Chairperson_of_DepartmentCaption_Control1000000015Lbl)
            {
            }
            column(Chairperson_SenateCaption; Chairperson_SenateCaptionLbl)
            {
            }
            column(Standard_DeviationCaption; Standard_DeviationCaptionLbl)
            {
            }
            column(Course_Registration_Reg__Transacton_ID; "Reg. Transacton ID")
            {
            }
            column(Course_Registration_Student_No_; "Student No.")
            {
            }
            column(Course_Registration_Programme; Programmes)
            {
            }
            column(Course_Registration_Semester; Semester)
            {
            }
            column(Course_Registration_Register_for; "Register for")
            {
            }
            column(Course_Registration_Stage; Stage)
            {
            }
            column(Course_Registration_Unit; Unit)
            {
            }
            column(Course_Registration_Student_Type; "Student Type")
            {
            }
            column(Course_Registration_Entry_No_; "Entry No.")
            {
            }

            trigger OnAfterGetRecord()
            begin

                SCount := SCount + 1;
                i := 0;
                TScore := 0;
                CFTotal := 0;
                RUnits := 0;
                MissingM := FALSE;
                MCourse := FALSE;
                strExamRMK := '';
                DTSCExist := FALSE;

                i := 0;
                REPEAT
                    i := i + 1;
                    ColumnV[i] := '';
                    AvScoreCount[i] := 0;
                //AvScore[i]:=0;
                UNTIL i = 80;
                i := 0;



                IF Dept = '' THEN BEGIN
                    IF Prog.GET(Programmes) THEN BEGIN
                        PName := Prog.Description;
                        FDesc := Prog."School Code";

                        i := 1;
                        Gradings.RESET;
                        Gradings.SETRANGE(Gradings.Category, Prog."Exam Category");
                        IF Gradings.FIND('-') THEN BEGIN
                            REPEAT
                                GLabel[i] := Gradings.Range;
                                GLabel2[i] := Gradings.Grade;
                                i := i + 1;
                            UNTIL Gradings.NEXT = 0;
                        END;

                        FacultyR.RESET;
                        FacultyR.SETRANGE(FacultyR.Code, Prog."School Code");
                        IF FacultyR.FIND('-') THEN
                            FDesc := FacultyR.Name;

                        i := 0;
                        DValue.RESET;
                        DValue.SETRANGE(DValue.Code, ProgrammeRec."Department Code");
                        DValue.SETRANGE(DValue."Dimension Code", 'DEPARTMENT');
                        IF DValue.FIND('-') THEN
                            Dept := DValue.Name;

                    END;

                    //IF Stages.GET("Course Registration".Programme,"Course Registration".Stage) THEN
                    SDesc := GETFILTER("Semester Filter");

                    //IF ProgOptions.GET("Course Registration".Programme,"Course Registration".Stage,GETFILTER("Options Filter")) THEN
                    //Comb:=ProgOptions.Desription;


                END;


                CALCFIELDS("Units Taken", "Units Passed",
                                                 "Units Failed");


                UnitsR.RESET;
                UnitsR.SETCURRENTKEY(UnitsR."Programme Code", UnitsR."Stage Code", UnitsR.Code, UnitsR."Programme Option");
                UnitsR.SETRANGE(UnitsR.Show, TRUE);
                UnitsR.SETRANGE(UnitsR."Old Unit", FALSE);
                UnitsR.SETFILTER(UnitsR."Student No. Filter", "Student No.");
                UnitsR.SETFILTER(UnitsR."Stage Filter", GETFILTER("Stage Filter"));
                UnitsR.SETFILTER(UnitsR."Semester Filter", GETFILTER("Semester Filter"));
                ////UnitsR.SETFILTER(UnitsR."Reg. ID Filter","Course Registration"."Reg. Transacton ID");
                IF UnitsR.FIND('-') THEN BEGIN
                    REPEAT
                        UnitsR.CALCFIELDS(UnitsR."Total Score", UnitsR."Unit Registered", UnitsR."Re-Sit", UnitsR.Audit);
                        USkip := FALSE;

                        //Check if option

                        /*
                        IF UnitsR."Programme Option" <> '' THEN BEGIN
                        IF UnitsR."Programme Option" <> "Course Registration".Options THEN
                        USkip := TRUE;
                        END;
                        */
                        //Check if option

                        GradeCategory := '';
                        ProgrammeRec.RESET;
                        IF ProgrammeRec.GET(Programmes) THEN
                            GradeCategory := ProgrammeRec."Exam Category";
                        IF GradeCategory = '' THEN ERROR('Please note that you must specify Exam Category in Programme Setup');


                        IF USkip = FALSE THEN BEGIN
                            Grade := '';
                            //Grades
                            IF UnitsR."Total Score" > 0 THEN BEGIN
                                Gradings.RESET;
                                Gradings.SETRANGE(Gradings.Category, GradeCategory);
                                LastGrade := '';
                                LastRemark := '';
                                LastScore := 0;
                                IF Gradings.FIND('-') THEN BEGIN
                                    ExitDo := FALSE;
                                    REPEAT
                                        IF UnitsR."Total Score" < LastScore THEN BEGIN
                                            IF ExitDo = FALSE THEN BEGIN
                                                Grade := LastGrade;
                                                Remarks := 'PASS';
                                                ExitDo := TRUE;
                                            END;
                                        END;
                                        LastGrade := Gradings.Grade;
                                        LastScore := Gradings."Up to";
                                        IF Gradings.Failed = TRUE THEN
                                            LastRemark := 'FAIL'
                                        ELSE
                                            LastRemark := 'PASS';

                                    UNTIL Gradings.NEXT = 0;

                                    IF ExitDo = FALSE THEN BEGIN
                                        Gradings2.RESET;
                                        Gradings2.SETRANGE(Gradings2.Category, GradeCategory);
                                        IF Gradings2.FIND('+') THEN BEGIN
                                            Grade := Gradings2.Grade;
                                            Remarks := Gradings2.Remarks;
                                        END;

                                    END;
                                END;

                            END ELSE BEGIN
                                Grade := '';
                                Remarks := 'Not Done';
                            END;
                            //Grades
                            //Course Category
                            IF UnitsR."Unit Type" = UnitsR."Unit Type"::Elective THEN
                                CCat := '-'
                            ELSE
                                CCat := '';

                            IF UnitsR."Re-Sit" > 0 THEN
                                CCat := '+';

                            IF UnitsR.Audit > 0 THEN
                                CCat := '#';


                            //Check if unit done
                            IF UnitsR."Unit Registered" < 1 THEN
                                CCat := '--';


                            //Course Category
                            /*
                            IF LastRemark<>'PASS' THEN
                            CCat:='*'
                            ELSE
                            CCat:='';
                            */

                            // CAT and EXAM Checking
                            //IF CheckCAT=TRUE THEN BEGIN
                            StudUnits.RESET;
                            StudUnits.SETRANGE(StudUnits."Student No.", "Student No.");
                            StudUnits.SETRANGE(StudUnits.Unit, UnitsR.Code);
                            StudUnits.SETRANGE(StudUnits.Semester, Semester);
                            StudUnits.SETRANGE(StudUnits."Old Unit", FALSE);
                            IF StudUnits.FIND('-') THEN BEGIN
                                StudUnits.CALCFIELDS(StudUnits."Exam Marks");
                                StudUnits.CALCFIELDS(StudUnits."CAT Total Marks");
                                StudUnits.CALCFIELDS(StudUnits."Total Score");
                                IF (StudUnits."Total Score") <> 0 THEN BEGIN
                                    IF StudUnits."Exam Marks" = 0 THEN BEGIN
                                        IF Sem.GET(Semester) THEN
                                            IF Sem."BackLog Marks" = FALSE THEN
                                                CCat := 'c';
                                        "Exam Status" := 'SUPP';
                                    END;
                                    IF StudUnits."CAT Total Marks" = 0 THEN BEGIN
                                        CCat := 'e';
                                        "Exam Status" := 'DSTC';
                                    END;
                                END;
                            END;
                            //END;

                            i := i + 1;
                            ColumnH[i] := UnitsR.Code;
                            ColumnV[i] := FORMAT(UnitsR."No. Units");
                            CFTotal := CFTotal + UnitsR."No. Units";
                            AvScore[i] := AvScore[i] + UnitsR."Total Score";

                            uColumnV[i] := FORMAT(UnitsR."No. Units");
                            sColumnV[i] := COPYSTR(UnitsR."Stage Code", 3, 2);
                            IF UnitsR."Total Score" = 0 THEN
                                IF CCat = '--' THEN
                                    ColumnV[i] := ''
                                ELSE BEGIN
                                    MissingM := TRUE;
                                    MCourse := TRUE;
                                    ColumnV[i] := 'X';
                                    DTSCExist := TRUE;
                                    //"Course Registration"."Exam Status":='DTSC';
                                    //RUnits:=RUnits+UnitsR."No. Units";



                                END
                            ELSE BEGIN

                                IF CCat = '' THEN
                                    IF GetGradeStatus(UnitsR."Total Score", Programmes, UnitsR.Code) = TRUE THEN BEGIN
                                        CCat := '^';
                                        "Exam Status" := 'SUPP';
                                    END;
                                //UnitsR.SETRANGE(Code,Programme);
                                //UnitsR.SETRANGE("Semester Filter","Semester Filter");
                                //UnitsR.SETRANGE("Stage Code",Stage);
                                //IF UnitsR.FINDFIRST THEN BEGIN
                                ColumnV[i] := FORMAT(ROUND(UnitsR."Total Score", 1, '=')) + CCat;
                                //ColumnV[i]:=FORMAT(UnitsR."Total Score") + CCat;
                                TScore := TScore + UnitsR."Total Score";
                                //END;
                                //RUnits:=RUnits+UnitsR."No. Units";
                            END;



                            IF DMarks = TRUE THEN
                                i := 0;

                        END;
                    UNTIL UnitsR.NEXT = 0;
                END;

                RepeatRemarks := '';
                StudUnits.RESET;
                StudUnits.SETRANGE(StudUnits."Student No.", "Student No.");
                StudUnits.SETRANGE(StudUnits.Programme, Programmes);
                StudUnits.SETRANGE(StudUnits.Semester, Semester);
                StudUnits.SETFILTER(StudUnits.Stage, GETFILTER("Stage Filter"));
                StudUnits.SETFILTER(StudUnits.Semester, GETFILTER("Semester Filter"));
                StudUnits.SETFILTER(StudUnits."Stage Filter", GETFILTER("Stage Filter"));
                StudUnits.SETFILTER(StudUnits."Semester Filter", GETFILTER("Semester Filter"));

                IF StudUnits.FIND('-') THEN BEGIN

                    REPEAT
                        StudUnits.CALCFIELDS(StudUnits."Total Score");
                        IF GetGradeStatus(UnitsR."Total Score", Programmes, UnitsR.Code) = TRUE THEN
                            StudUnits."Result Status" := 'FAIL'
                        ELSE
                            StudUnits."Result Status" := 'PASS';

                        IF StudUnits."Total Score" = 0 THEN
                            StudUnits."Result Status" := 'FAIL';
                        StudUnits.Grade := GetGrade(StudUnits."Total Score", StudUnits.Unit);
                        StudUnits."Final Score" := StudUnits."Total Score" * StudUnits."No. Of Units";
                        ;

                    //StudUnits.MODIFY;
                    UNTIL StudUnits.NEXT = 0;
                END;




                IF Cust.GET("Student No.") THEN

                    //Generate Summary
                    UTaken := 0;
                UPassed := 0;
                UFailed := 0;
                CAve := 0;

                IF DSummary = FALSE THEN BEGIN

                    //Jump one column

                    i := i + 1;
                    ColumnH[i] := '';
                    ColumnV[i] := '';


                    CReg.RESET;
                    CReg.SETRANGE(CReg."Student No.", "Student No.");
                    //CReg.SETRANGE(CReg.Reversed,FALSE);
                    CReg.SETFILTER(CReg.Stage, GETFILTER("Stage Filter"));
                    CReg.SETFILTER(CReg.Semester, GETFILTER("Semester Filter"));
                    CReg.SETFILTER(CReg.Programmes, GETFILTER("Programme Filter"));
                    CReg.SETFILTER(CReg."Stage Filter", GETFILTER("Stage Filter"));
                    CReg.SETFILTER(CReg."Semester Filter", GETFILTER("Semester Filter"));

                    IF CReg.FIND('-') THEN BEGIN
                        REPEAT
                            CReg.CALCFIELDS(CReg."Units Taken", CReg."Units Passed",
                                                             CReg."Units Failed", CReg."Units Repeat");

                            UTaken := UTaken + CReg."Units Taken";
                            UPassed := UPassed + CReg."Units Passed";
                            UFailed := UFailed + CReg."Units Failed" + CReg."Units Repeat";

                        UNTIL CReg.NEXT = 0;
                    END;

                    CALCFIELDS("Cum Average");
                    CALCFIELDS("Cum Units Done");
                    CALCFIELDS("Cum Units Failed");
                    //CALCFIELDS("Year Of Study");
                    CALCFIELDS("Cum Units Passed");
                    CALCFIELDS("CF Count");
                    CALCFIELDS("CF Total Score");


                    /*
                    i:=i+1;
                    ColumnH[i]:='Reg Units';
                    //ColumnV[i]:=FORMAT(UTaken);
                    ColumnV[i]:=FORMAT("Course Registration"."Cum Units Done");
                    */
                    //TReg:=TReg+1;
                    AvScoreCount[i] := AvScoreCount[i] + "Cum Units Done";

                    //ColumnV[i]:=FORMAT(ROUND(YearScore/CourseCount,1,'='));
                    //CAve:=ROUND(YearScore/CourseCount,1,'=');
                    i := i + 1;
                    ColumnH[i] := 'Total Units';
                    CALCFIELDS("CF Count");
                    ColumnV[i] := FORMAT("CF Count");

                    i := i + 1;
                    ColumnH[i] := 'Weighted Total';
                    CALCFIELDS("CF Total Score");
                    ColumnV[i] := FORMAT("CF Total Score");

                    i := i + 1;
                    ColumnH[i] := 'Units Passed';
                    //IF UTaken > 0 THEN
                    ColumnV[i] := FORMAT("Year Of Study");
                    //AvScore[i]:=AvScore[i]+"Course Registration"."Cum Units Passed";


                    i := i + 1;
                    ColumnH[i] := 'Units Failed';
                    //CALCFIELDS("Yearly Grade") ;
                    ColumnV[i] := FORMAT("Yearly Grade");
                    //AvScore[i]:=AvScore[i]+"Course Registration"."Cum Units Failed";

                    i := i + 1;
                    //CALCFIELDS("Cum Units Special") ;
                    ColumnH[i] := 'Units Special';
                    ColumnV[i] := FORMAT("Total Yearly Marks");


                    i := i + 1;

                    decAverage := 0;

                    ColumnH[i] := 'CF% Failed';
                    IF ("Cum Units Passed" <> 0) AND ("Cum Units Done" <> 0) THEN BEGIN
                        //ColumnV[i]:=FORMAT(ROUND((("Cum Units Done"-("Cum Units Passed"+"Cum Units Special"))/
                        //"Cum Units Done")*100,0.01,'='));
                        //ColumnV[i]:=FORMAT(ROUND(("Yearly Grade")/("CF Count")*100,0.01,'='));

                        decAverage := ROUND((("Cum Units Done" - ("Cum Units Passed" + "Total Yearly Marks")) /
                        "Cum Units Done") * 100, 0.01, '=');

                        IF "Cum Units Done" <> 0 THEN
                            IF (("Cum Units Done" - "Cum Units Passed") / "Cum Units Done") * 100 > 25.01 THEN
                                "Exam Status" := 'REPEAT';

                        IF "Cum Units Done" <> 0 THEN
                            IF (("Cum Units Done" - "Cum Units Passed") / "Cum Units Done") * 100 > 50.01 THEN
                                "Exam Status" := 'Discontinue';

                        IF "Cum Units Done" <> 0 THEN
                            IF ("CF Count" = "Year Of Study") THEN //AND ("Cum Units Done">0) THEN
                                "Exam Status" := 'PASS';


                        //MODIFY;

                    END;

                    i := i + 1;
                    //calculate yearly average
                    ColumnH[i] := 'Curr Average';
                    IF ("Cum Average" > 0) AND ("Cum Units Done" > 0) THEN BEGIN
                        ColumnV[i] := FORMAT(ROUND("Cum Average" / "Cum Units Done", 0.01, '>'));
                        //AvScore[i]:=AvScore[i]+ROUND("Course Registration"."Cum Average"/"Course Registration"."Cum Units Done",0.01,'>');
                        "Cumm Score" := ROUND("Cum Average" / "Cum Units Done", 0.01, '>');
                        IF STRLEN(ColumnV[i]) = 2 THEN
                            ColumnV[i] := ColumnV[i] + '.00';
                        IF STRLEN(ColumnV[i]) = 4 THEN
                            ColumnV[i] := ColumnV[i] + '0';

                    END;
                    //"Course Registration".MODIFY;
                    /*
                    i:=i+1;

                    //calculate yearly average GRADE
                    DefUnit:='DEF';
                    ColumnH[i]:='Grade';
                    IF ("Course Registration"."Cum Average" > 0) AND ("Course Registration"."Cum Units Done">0) THEN
                    ColumnV[i]:=GetGrade("Course Registration"."Cumm Score",DefUnit);
                    */
                    i := i + 1;

                    ColumnH[i] := 'Rmk';

                    //***************Dennos


                    IF ("Cum Units Failed" > 0) AND ("Total Yearly Marks" > 0) THEN
                        "Exam Status" := 'SUPPSPECIAL';

                    IF DTSCExist = FALSE THEN BEGIN

                        //IF (decAverage >= 25.01) AND (decAverage <= 50) THEN "Exam Status":='PASS' ELSE
                        //IF (decAverage >=50.01) THEN
                        BEGIN
                            // "Exam Status":='DISCONTINUED';
                        END;

                    END;
                    IF "Cum Units Done" <> 0 THEN
                        IF (("Cum Units Done" - "Cum Units Passed") / "Cum Units Done") * 100 < 25.0 THEN
                            "Exam Status" := 'SUPP';
                    IF "Cum Units Done" <> 0 THEN
                        IF (("Cum Units Done" - "Cum Units Passed") / "Cum Units Done") * 100 > 25.01 THEN
                            "Exam Status" := 'REPEAT';
                    IF "Cum Units Done" <> 0 THEN
                        IF (("Cum Units Done" - "Cum Units Passed") / "Cum Units Done") * 100 > 50.01 THEN
                            "Exam Status" := 'Discontinued';

                    IF "Cum Units Done" <> 0 THEN
                        IF ("CF Count" = "Year Of Study") THEN //AND ("Cum Units Done">0) THEN
                            "Exam Status" := 'PASS';

                    IF DTSCExist = TRUE THEN "Exam Status" := 'DTSC';
                    //--------------ENd Denno

                    //MODIFY;

                    IF ResultStatus.GET("Exam Status") THEN
                        ColumnV[i] := ResultStatus.Prefix;

                    /*
                    IF "Course Registration"."Exam Status"='PASS' THEN
                    IF ("Course Registration"."Cum Units Failed"<>0) THEN
                    ColumnV[i]:='FAIL';


                    IF ResultStatus.GET("Course Registration"."Exam Status") THEN
                    IF ResultStatus."Manual Status Processing"=FALSE THEN BEGIN

                    IF ("Course Registration"."Cum Units Done" <> 0) AND ("Course Registration"."Cum Units Passed"<>0)
                    AND ("Course Registration"."Cum Units Failed"=0) THEN
                    IF "Course Registration"."Cum Units Done"="Course Registration"."Cum Units Passed" THEN BEGIN

                    TPass:=TPass+1;
                    IF ResultStatus.GET('PASS') THEN BEGIN
                    ColumnV[i]:=ResultStatus.Prefix;
                    "Course Registration"."Exam Status":='PASS';

                    //"Course Registration".MODIFY;
                    END;
                    END;


                    IF "Course Registration"."Cum Units Failed" > 0 THEN BEGIN
                    IF ResultStatus.GET("Course Registration"."Exam Status") THEN
                    IF ResultStatus."Manual Status Processing"=FALSE THEN BEGIN

                    IF ResultStatus.GET('FAIL') THEN BEGIN
                    ColumnV[i]:=ResultStatus.Prefix;
                    "Course Registration"."Exam Status":='FAIL';
                    //"Course Registration".MODIFY;
                    END;
                    IF MCourse = FALSE THEN
                    TFail:=TFail+1;
                    END;
                    END;

                    IF MCourse = TRUE THEN BEGIN
                    IF ResultStatus.GET("Course Registration"."Exam Status") THEN
                    IF ResultStatus."Manual Status Processing"=FALSE THEN BEGIN
                    IF ResultStatus.GET('INCOMPLETE') THEN
                    ColumnV[i]:=ResultStatus.Prefix;

                    "Course Registration"."Exam Status":='INCOMPLETE';
                    //"Course Registration".MODIFY;
                    END;
                    TMiss:=TMiss+1;
                    END;

                    IF "Course Registration"."Cum Units Failed" >7 THEN BEGIN
                    IF ResultStatus.GET("Course Registration"."Exam Status") THEN
                    IF ResultStatus."Manual Status Processing"=FALSE THEN BEGIN

                    //IF ResultStatus.GET('DISCONTINUED') THEN
                    //ColumnV[i]:=ResultStatus.Prefix;
                    //"Course Registration"."Exam Status":='DISCONTINUED';..............FL
                    //"Course Registration".MODIFY;

                    TDiscount:=TDiscount+1;
                    END;
                    END;
                    IF ("Course Registration"."Cum Units Failed" <8) AND ("Course Registration"."Cum Units Failed" >5) THEN BEGIN
                    IF ResultStatus.GET("Course Registration"."Exam Status") THEN
                    IF ResultStatus."Manual Status Processing"=FALSE THEN BEGIN

                    IF ResultStatus.GET('REPEAT') THEN
                    ColumnV[i]:=ResultStatus.Prefix;
                    "Course Registration"."Exam Status":='REPEAT';
                    //"Course Registration".MODIFY;

                    TRepeat:=TRepeat+1;
                    END;
                    END;
                     {
                    IF Prog.GET("Course Registration".Programme) THEN BEGIN
                    IF "Course Registration"."Units Taken" < Prog."Min No. of Courses" THEN
                    ColumnV[i]:='?';
                    END;
                    }
                    IF Cust.Status=Cust.Status::"Dropped Out" THEN
                    ColumnV[i]:='Z';

                    {
                    IF (UTaken < 1) OR ((UPassed<14) AND (ColumnV[i]='P')) THEN   //BKK
                    ColumnV[i]:='?';


                    i:=i+1;
                    ColumnH[i]:='Brd Rmk';
                    ColumnV[i]:='';
                     }
                    END;
                     */

                END;
                IF ColumnV[i] = 'PASS' THEN BEGIN
                    i := i + 1;
                    //calculate yearly average
                    ColumnH[i] := 'Cumm Average';
                    MaxStage := GETRANGEMAX("Stage Filter");
                    SETFILTER("Cummulative Year Filter", '%1..%2', '', MaxStage);
                    CALCFIELDS("CF Count");
                    CALCFIELDS("Total CF Count");
                    IF ("CF Count" > 0) AND ("Total CF Count" > 0) THEN BEGIN
                        ColumnV[i] := FORMAT(ROUND("Total CF Count" / "Total CF Count", 0.01, '>'));
                        //AvScore[i]:=AvScore[i]+ROUND("Course Registration"."Cum Average"/"Course Registration"."Cum Units Done",0.01,'>');
                        //"Course Registration"."Cumm Score":=ROUND("Course Registration"."Cum Average"/"Course Registration"."Cum Units Done",0.01,'>');
                        IF STRLEN(ColumnV[i]) = 2 THEN
                            ColumnV[i] := ColumnV[i] + '.00';
                        IF STRLEN(ColumnV[i]) = 4 THEN
                            ColumnV[i] := ColumnV[i] + '0';

                    END;
                END;
                //Generate Summary
                // Units Key
                i := 0;
                UnitsR.RESET;
                UnitsR.SETRANGE(UnitsR.Show, TRUE);
                IF UnitsR.FIND('-') THEN BEGIN
                    REPEAT
                        i := i + 1;
                        IF i < 25 THEN
                            ColumnUN[i] := UnitsR.Code + ' - ' + UnitsR.Desription;
                    UNTIL UnitsR.NEXT = 0;
                END;

                //Summary
                i := 1;
                ResultStatus.RESET;
                ResultStatus.SETCURRENTKEY(ResultStatus."Order No");
                ResultStatus.SETFILTER(ResultStatus."Programme Filter", GETFILTER("Programme Filter"));
                ResultStatus.SETFILTER(ResultStatus."Stage Filter", GETFILTER("Stage Filter"));
                ResultStatus.SETFILTER(ResultStatus.Semester, GETFILTER(Semester));
                ResultStatus.SETFILTER(ResultStatus."Session Filter", GETFILTER(Session));
                IF ResultStatus.FIND('-') THEN BEGIN
                    REPEAT
                        IF ResultStatus."Order No" <> 0 THEN BEGIN
                            ResultStatus.CALCFIELDS(ResultStatus."Students Count");
                            SMM[i] := ResultStatus.Code + '=' + FORMAT(ResultStatus."Students Count");
                            TReg := TReg + ResultStatus."Students Count";
                            i := i + 1;
                        END;
                    UNTIL ResultStatus.NEXT = 0;
                END;

                j := 2;
                FOR i := 1 TO 80 DO BEGIN
                    IF j < 80 THEN
                        j := j + 1;
                    StudUnits.RESET;
                    StudUnits.SETRANGE(StudUnits.Unit, ColumnH[i]);
                    StudUnits.SETFILTER(StudUnits.Programme, GETFILTER("Programme Filter"));
                    StudUnits.SETFILTER(StudUnits.Stage, GETFILTER("Stage Filter"));
                    StudUnits.SETFILTER(StudUnits.Semester, GETFILTER("Semester Filter"));
                    StudUnits.SETFILTER(StudUnits."Final Score", '<>%1', 0);
                    IF StudUnits.FIND('-') THEN BEGIN
                        REPEAT
                            AvScore[i] := AvScore[i] + StudUnits."Final Score";
                        UNTIL StudUnits.NEXT = 0;
                    END;
                    // ColumnVA[i]:=FORMAT((TReg));
                    IF (AvScore[i] <> 0) AND (TReg <> 0) THEN BEGIN
                        ColumnVA[i] := FORMAT(ROUND((AvScore[i] / TReg), 0.5, '>'));
                        STD[i] := STD[i] + ROUND((AvScore[i] - (AvScore[i] / TReg)), 0.5, '>');

                    END;
                    IF STD[i] > 0 THEN BEGIN
                        STD[i] := POWER((STD[i] / COUNT), 0.5);
                        ColumnSD[i] := FORMAT(ROUND(STD[i], 0.01, '>'));
                    END;
                    StudUnits.RESET;
                    //StudUnits.SETCURRENTKEY("Final Graduating Marks");
                    StudUnits.SETRANGE(StudUnits.Unit, ColumnH[i]);
                    StudUnits.SETFILTER(StudUnits.Programme, GETFILTER("Programme Filter"));
                    StudUnits.SETFILTER(StudUnits.Stage, GETFILTER("Stage Filter"));
                    StudUnits.SETFILTER(StudUnits.Semester, GETFILTER("Semester Filter"));
                    StudUnits.SETFILTER(StudUnits."Final Score", '<>%1', 0);
                    IF StudUnits.FIND('+') THEN
                        ColumnVM[i] := FORMAT(ROUND(StudUnits."Final Score", 0.01, '>'));

                    StudUnits.RESET;
                    //StudUnits.SETCURRENTKEY("Final Graduating Marks");
                    StudUnits.SETRANGE(StudUnits.Unit, ColumnH[i]);
                    StudUnits.SETFILTER(StudUnits.Programme, GETFILTER("Programme Filter"));
                    StudUnits.SETFILTER(StudUnits.Stage, GETFILTER("Stage Filter"));
                    StudUnits.SETFILTER(StudUnits.Semester, GETFILTER("Semester Filter"));
                    StudUnits.SETFILTER(StudUnits."Final Score", '<>%1', 0);
                    IF StudUnits.FIND('-') THEN
                        ColumnVX[i] := FORMAT(ROUND(StudUnits."Final Score", 0.01, '>'));
                    //   ColumnVX[i]:='000';
                    // END;
                END;
                i := 0;
                UnitsR.RESET;
                UnitsR.SETRANGE(UnitsR.Show, TRUE);
                IF UnitsR.FIND('-') THEN BEGIN
                    REPEAT
                        i := i + 1;
                        IF i < 25 THEN
                            ColumnUN[i] := UnitsR.Code + ' - ' + UnitsR.Desription;
                    UNTIL UnitsR.NEXT = 0;
                END;

                CReg.RESET;
                CReg.SETCURRENTKEY("Student No.", "Cumm Score");
                CReg.ASCENDING := TRUE;
                CReg.SETRANGE(CReg.Programmes, Programmes);
                CReg.SETFILTER(CReg.Stage, GETFILTER("Stage Filter"));
                CReg.SETFILTER(CReg.Semester, GETFILTER("Semester Filter"));
                //IF CReg.FIND('-') THEN

            end;

            trigger OnPreDataItem()
            begin
                CompInf.GET;
                CompInf.CALCFIELDS(CompInf.Picture);
                FDesc := '';
                //Dept:='';
                SDesc := '';
                Comb := '';

                SCount := 0;
                GenSetup.GET;

                Sem.RESET;
                Sem.SETFILTER(Sem.Code, GETFILTER(Semester));
                IF Sem.FIND('-') THEN
                    SemYear := Sem."Academic Year";

                YearDesc := COPYSTR(GETFILTER("Stage Filter"), 2, 1);
                IF YearDesc = '1' THEN
                    YearDesc := 'FIRST';
                IF YearDesc = '2' THEN
                    YearDesc := 'SECOND';
                IF YearDesc = '3' THEN
                    YearDesc := 'THIRD';
                IF YearDesc = '4' THEN
                    YearDesc := 'FOURTH';

                //Intake:=CReg."Intake Code";
                SETFILTER(Programmes, GETFILTER("Programme Filter"));
                //SETFILTER(Semester,GETFILTER("Semester Filter"));
                SETFILTER(Options, GETFILTER("Options Filter"));
                SETFILTER(Stage, GETFILTER("Stage Filter"));

                IF Prog.GET(GETFILTER("Programme Filter")) THEN BEGIN
                    PName := Prog.Description;
                    FDesc := Prog."School Code";


                    FacultyR.RESET;
                    FacultyR.SETRANGE(FacultyR.Code, Prog."School Code");
                    IF FacultyR.FIND('-') THEN
                        FDesc := FacultyR.Name;

                    DValue.RESET;
                    DValue.SETRANGE(DValue.Code, Prog."Department Code");
                    DValue.SETRANGE(DValue."Dimension Code", 'DEPARTMENT');
                    IF DValue.FIND('-') THEN
                        Dept := DValue.Name;

                END;

                UnitsR.RESET;
                UnitsR.MODIFYALL(UnitsR.Show, FALSE);
                StudUnits.RESET;
                StudUnits.MODIFYALL(StudUnits.Show, FALSE);

                CReg.RESET;
                CReg.SETFILTER(CReg.Programmes, GETFILTER("Programme Filter"));
                CReg.SETFILTER(CReg.Stage, GETFILTER("Stage Filter"));
                CReg.SETFILTER(CReg.Options, GETFILTER("Options Filter"));
                CReg.SETFILTER(CReg.Semester, GETFILTER("Semester Filter"));
                //CReg.SETRANGE(CReg./,FALSE);
                IF CReg.FIND('-') THEN BEGIN
                    REPEAT

                        StudUnits.RESET;
                        //StudUnits.SETCURRENTKEY(StudUnits."Reg. Transacton ID",StudUnits."Student No.");
                        StudUnits.SETRANGE(StudUnits.Programme, CReg.Programmes);
                        //StudUnits.SETRANGE(StudUnits."Reg. Transacton ID",CReg."Reg. Transacton ID");
                        StudUnits.SETRANGE(Semester, CReg.Semester);
                        StudUnits.SETRANGE(StudUnits."Student No.", CReg."Student No.");
                        StudUnits.SETFILTER(StudUnits.Stage, GETFILTER("Stage Filter"));
                        StudUnits.SETFILTER(StudUnits."Semester Filter", GETFILTER("Semester Filter"));
                        StudUnits.SETFILTER(StudUnits.Semester, CReg.Semester);
                        StudUnits.SETFILTER(StudUnits."Reg Option", GETFILTER("Options Filter"));
                        StudUnits.SETFILTER(StudUnits."Session Code", GETFILTER(Session));
                        StudUnits.SETRANGE(StudUnits."Old Unit", FALSE);
                        //StudUnits.SETRANGE(StudUnits.Taken,TRUE);
                        StudUnits.SETRANGE(Blocked, 0);
                        //StudUnits.SETFILTER(TotalScore,'>%1',0);
                        IF ShowResit = TRUE THEN
                            StudUnits.SETRANGE(StudUnits."Re-Take", FALSE);
                        IF StudUnits.FIND('-') THEN BEGIN

                            REPEAT
                                StudUnits.CALCFIELDS("Reg Option");
                                //IF StudUnits."Total Score">0 THEN
                                UnitsR.RESET;
                                UnitsR.SETCURRENTKEY(UnitsR."Programme Code", UnitsR."Stage Code", UnitsR.Code);
                                UnitsR.SETRANGE(UnitsR."Programme Code", StudUnits.Programme);
                                UnitsR.SETRANGE(UnitsR."Stage Code", StudUnits.Stage);

                                UnitsR.SETRANGE(UnitsR.Code, StudUnits.Unit);
                                UnitsR.SETRANGE(UnitsR."Old Unit", FALSE);
                                IF UnitsR.FIND('-') AND (ShowCount < 60) THEN BEGIN
                                    IF UnitsR.Show = FALSE THEN BEGIN
                                        //END ELSE BEGIN
                                        ShowCount := ShowCount + 1;
                                        UnitsR.Show := TRUE;
                                        //IF StudUnits."Reg Option"=CReg.Options THEN
                                        IF UnitsR."Unit Type" = UnitsR."Unit Type"::Core THEN
                                            UnitsR.MODIFY;

                                        IF StudUnits."Reg Option" = CReg.Options THEN
                                            UnitsR.MODIFY;

                                        //END;
                                    END;
                                END;
                                StudUnits.Show := TRUE;
                                StudUnits.MODIFY;

                            UNTIL StudUnits.NEXT = 0;
                        END;
                        IF (CReg.Options <> '') THEN BEGIN
                            OptionsComb.RESET;
                            //OptionsComb.SETRANGE(OptionsComb.Unit,UnitsR.Code);
                            OptionsComb.SETRANGE(OptionsComb."Programme Code", CReg.Programmes);
                            //OptionsComb.SETRANGE(OptionsComb.,CReg.Options);
                            OptionsComb.SETRANGE(OptionsComb."Stage Code", CReg.Stage);
                            IF OptionsComb.FIND('-') THEN BEGIN
                                REPEAT
                                    UnitsR.RESET;
                                    UnitsR.SETRANGE(UnitsR.Code, OptionsComb.Code);
                                    UnitsR.SETRANGE(UnitsR."Programme Code", CReg.Programmes);
                                    UnitsR.SETRANGE(UnitsR."Stage Code", CReg.Stage);
                                    IF UnitsR.FIND('-') THEN BEGIN
                                        //ShowCount:=ShowCount+1;
                                        UnitsR.Show := TRUE;
                                        //UnitsR.MODIFY;
                                    END;
                                UNTIL OptionsComb.NEXT = 0;
                            END;
                        END;
                    UNTIL CReg.NEXT = 0;
                END;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                field(DMarks; DMarks)
                {
                    Caption = 'Dont Show Marks';
                    ApplicationArea = All;
                }
                field(CheckCAT; CheckCAT)
                {
                    Caption = 'Check if CATs and EXAMs Exists';
                    ApplicationArea = All;
                }
                field(ShowResit; ShowResit)
                {
                    Caption = 'Dont Show Re-Sit Units';
                    ApplicationArea = All;
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        Cust: Record 18;
        Charges: Record 61515;
        ColumnH: array[80] of Text[100];
        ColumnV: array[80] of Text[30];
        ColumnVM: array[80] of Text[30];
        ColumnVX: array[80] of Text[30];
        ColumnVA: array[80] of Text[30];
        ColumnSD: array[80] of Text[200];
        ColumnUN: array[80] of Text[200];
        i: Integer;
        j: Integer;
        TColumnV: array[80] of Decimal;
        SCount: Integer;
        UnitsR: Record 61517;
        UnitsRR: Record 61517;
        uColumnV: array[80] of Text[30];
        sColumnV: array[80] of Text[30];
        Prog: Record 61511;
        Stages: Record 61516;
        RFound: Boolean;
        UDesc: Text[200];
        Units: Record 61517;
        Result: Decimal;
        Grade: Text[150];
        Remarks: Text[150];
        Gradings: Record 61599;
        Gradings2: Record 61599;
        TotalScore: Decimal;
        LastGrade: Code[20];
        LastScore: Decimal;
        ExitDo: Boolean;
        Desc: Text[200];
        OScore: Decimal;
        OUnits: Integer;
        MeanScore: Decimal;
        MeanGrade: Code[20];
        LastRemark: Text[200];
        CCat: Text[30];
        TScore: Decimal;
        RUnits: Decimal;
        SkipCount: Integer;
        MissingM: Boolean;
        DValue: Record 349;
        FDesc: Text[200];
        Dept: Text[200];
        PName: Text[200];
        SDesc: Text[200];
        Comb: Text[200];
        DMarks: Boolean;
        DSummary: Boolean;
        USkip: Boolean;
        CReg: Record 61532;
        UTaken: Integer;
        UPassed: Integer;
        UFailed: Integer;
        MCourse: Boolean;
        StudUnits: Record 61549;
        StudUnits2: Record 61549;
        UnitCount: Integer;
        YearScore: Decimal;
        CourseCount: Decimal;
        DontCont: Boolean;
        CAve: Decimal;
        Intake: Record 61383;
        ShowCount: Integer;
        GradeCategory: Code[20];
        ProgrammeRec: Record 61511;
        GLabel: array[6] of Code[20];
        GLabel2: array[6] of Code[100];
        FacultyR: Record 349;
        TReg: Integer;
        TPass: Integer;
        TFail: Integer;
        TMiss: Integer;
        TSupp: Integer;
        CheckCAT: Boolean;
        AvScore: array[80] of Decimal;
        MinScore: array[80] of Decimal;
        AvScoreCount: array[80] of Decimal;
        RepeatRemarks: Text[30];
        STD: array[81] of Decimal;
        GenSetup: Record 61534;
        Sem: Record 61692;
        SemYear: Code[100];
        ShowResit: Boolean;
        TRepeat: Integer;
        TDiscount: Integer;
        ResultStatus: Record 61739;
        SMM: array[20] of Text[100];
        DefUnit: Code[20];
        School_CaptionLbl: Label 'School:';
        Department_CaptionLbl: Label 'Department:';
        Programme_of_Study_CaptionLbl: Label 'Programme of Study:';
        Stage_CaptionLbl: Label 'Stage:';
        Academic_Year_CaptionLbl: Label 'Academic Year:';
        Consolidated_MarksheetCaptionLbl: Label 'Consolidated Marksheet';
        Semester_CaptionLbl: Label 'Semester:';
        Registration_No_CaptionLbl: Label 'Registration No.';
        NamesCaptionLbl: Label 'Names';
        UNITS__CaptionLbl: Label 'UNITS=>';
        EmptyStringCaptionLbl: Label '#';
        Units_Key_CaptionLbl: Label 'Units Key:';
        Approved_by_the_Departmental_Board_of_ExaminersCaptionLbl: Label 'Approved by the Departmental Board of Examiners';
        Approved_by_the_School_Board_of_ExaminersCaptionLbl: Label 'Approved by the School Board of Examiners';
        Signed_______________________________________CaptionLbl: Label 'Signed:______________________________________';
        Signed_______________________________________Caption_Control1102755449Lbl: Label 'Signed:______________________________________';
        Signed_______________________________________Caption_Control1102755450Lbl: Label 'Signed:______________________________________';
        Approved_by_DeKUT_SenateCaptionLbl: Label 'Approved by DeKUT Senate';
        Chairperson_of_DepartmentCaptionLbl: Label 'Chairperson of Department';
        AG_VC_DeKUTCaptionLbl: Label 'AG.VC DeKUT';
        Guide_on_Remarks_CaptionLbl: Label 'Guide on Remarks:';
        Guide_on_remarks_Caption_Control1102760087Lbl: Label 'Guide on remarks:';
        Total_Reg_CaptionLbl: Label 'Total Reg.';
        Mean_ScoreCaptionLbl: Label 'Mean Score';
        Maximum_ScoreCaptionLbl: Label 'Maximum Score';
        Minimum_ScoreCaptionLbl: Label 'Minimum Score';
        Units_Key_Caption_Control1102755384Lbl: Label 'Units Key:';
        Approved_by_the_Departmental_Board_of_ExaminersCaption_Control1000000009Lbl: Label 'Approved by the Departmental Board of Examiners';
        Approved_by_the_School_Board_of_ExaminersCaption_Control1000000010Lbl: Label 'Approved by the School Board of Examiners';
        Signed_______________________________________Caption_Control1000000011Lbl: Label 'Signed:______________________________________';
        Signed_______________________________________Caption_Control1000000012Lbl: Label 'Signed:______________________________________';
        Signed_______________________________________Caption_Control1000000013Lbl: Label 'Signed:______________________________________';
        Approved_by_DeKUT_SenateCaption_Control1000000014Lbl: Label 'Approved by DeKUT Senate';
        Chairperson_of_DepartmentCaption_Control1000000015Lbl: Label 'Chairperson of Department';
        Chairperson_SenateCaptionLbl: Label 'Chairperson Senate';
        Standard_DeviationCaptionLbl: Label 'Standard Deviation';
        CompInf: Record 79;
        UnitNo: Text;
        YearDesc: Code[20];
        CFTotal: Decimal;
        OptionsComb: Record 61554;
        strExamRMK: Text;
        decAverage: Decimal;
        DTSCExist: Boolean;
        MaxStage: Code[20];

    /// <summary>
    /// GetGrade.
    /// </summary>
    /// <param name="Marks">Decimal.</param>
    /// <param name="UnitG">Code[20].</param>
    /// <returns>Return variable xGrade of type Text[100].</returns>
    procedure GetGrade(Marks: Decimal; UnitG: Code[20]) xGrade: Text[100]
    begin
        GradeCategory := '';
        UnitsRR.RESET;
        UnitsRR.SETRANGE(UnitsRR."Programme Code");
        UnitsRR.SETRANGE(UnitsRR.Code, UnitG);
        UnitsRR.SETRANGE(UnitsRR."Stage Code");
        IF (UnitsRR.FIND('-')) AND (UnitsRR."Default Exam Category" <> '') THEN BEGIN
            GradeCategory := UnitsRR."Default Exam Category";
        END ELSE BEGIN
            ProgrammeRec.RESET;
#pragma warning disable AL0697
            IF ProgrammeRec.GET(ProgrammeRec) THEN
#pragma warning restore AL0697
                GradeCategory := ProgrammeRec."Exam Category";
            IF GradeCategory = '' THEN ERROR('Please note that you must specify Exam Category in Programme Setup');
        END;

        xGrade := '';
        IF Marks > 0 THEN BEGIN
            Gradings.RESET;
            Gradings.SETRANGE(Gradings.Category, GradeCategory);
            LastGrade := '';
            LastRemark := '';
            LastScore := 0;
            IF Gradings.FIND('-') THEN BEGIN
                ExitDo := FALSE;
                REPEAT
                    LastScore := Gradings."Up to";
                    IF Marks < LastScore THEN BEGIN
                        IF ExitDo = FALSE THEN BEGIN
                            xGrade := Gradings.Grade;
                            IF Gradings.Failed = FALSE THEN
                                LastRemark := 'PASS'
                            ELSE
                                LastRemark := 'FAIL';
                            ExitDo := TRUE;
                        END;
                    END;

                UNTIL Gradings.NEXT = 0;


            END;

        END ELSE BEGIN
            Grade := '';
            //Remarks:='Not Done';
        END;
    end;

    /// <summary>
    /// GetGradeStatus.
    /// </summary>
    /// <param name="AvMarks">VAR Decimal.</param>
    /// <param name="ProgCode">VAR Code[20].</param>
    /// <param name="Unit">VAR Code[20].</param>
    /// <returns>Return variable F of type Boolean.</returns>
    procedure GetGradeStatus(var AvMarks: Decimal; var ProgCode: Code[20]; var Unit: Code[20]) F: Boolean
    var
        LastGrade: Code[20];
        LastRemark: Code[20];
        ExitDo: Boolean;
        LastScore: Decimal;
        Gradings: Record 61599;
        Gradings2: Record 61599;
        GradeCategory: Code[20];
        GLabel: array[6] of Code[20];
        i: Integer;
        GLabel2: array[6] of Code[100];
        FStatus: Boolean;
        ProgrammeRec: Record 61511;
        Grd: Code[80];
    begin
        F := FALSE;

        GradeCategory := '';
        UnitsRR.RESET;
        UnitsRR.SETRANGE(UnitsRR."Programme Code", ProgCode);
        UnitsRR.SETRANGE(UnitsRR.Code, Unit);
        //UnitsRR.SETRANGE(UnitsRR."Stage Code","Course Registration".Stage);
        IF UnitsRR.FIND('-') THEN BEGIN
            IF UnitsRR."Default Exam Category" <> '' THEN BEGIN
                GradeCategory := UnitsRR."Default Exam Category";
            END ELSE BEGIN
                ProgrammeRec.RESET;
                IF ProgrammeRec.GET(ProgCode) THEN
                    GradeCategory := ProgrammeRec."Exam Category";
                IF GradeCategory = '' THEN ERROR('Please note that you must specify Exam Category in Programme Setup');
            END;
        END;

        IF AvMarks > 0 THEN BEGIN
            Gradings.RESET;
            Gradings.SETRANGE(Gradings.Category, GradeCategory);
            LastGrade := '';
            LastRemark := '';
            LastScore := 0;
            IF Gradings.FIND('-') THEN BEGIN
                ExitDo := FALSE;
                REPEAT
                    LastScore := Gradings."Up to";
                    IF AvMarks < LastScore THEN BEGIN
                        IF ExitDo = FALSE THEN BEGIN
                            Grd := Gradings.Grade;
                            F := Gradings.Failed;
                            ExitDo := TRUE;
                        END;
                    END;

                UNTIL Gradings.NEXT = 0;


            END;

        END ELSE BEGIN


        END;
    end;
}

