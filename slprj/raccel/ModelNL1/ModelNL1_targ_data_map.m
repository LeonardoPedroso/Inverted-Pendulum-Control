  function targMap = targDataMap(),

  ;%***********************
  ;% Create Parameter Map *
  ;%***********************
      
    nTotData      = 0; %add to this count as we go
    nTotSects     = 1;
    sectIdxOffset = 0;
    
    ;%
    ;% Define dummy sections & preallocate arrays
    ;%
    dumSection.nData = -1;  
    dumSection.data  = [];
    
    dumData.logicalSrcIdx = -1;
    dumData.dtTransOffset = -1;
    
    ;%
    ;% Init/prealloc paramMap
    ;%
    paramMap.nSections           = nTotSects;
    paramMap.sectIdxOffset       = sectIdxOffset;
      paramMap.sections(nTotSects) = dumSection; %prealloc
    paramMap.nTotData            = -1;
    
    ;%
    ;% Auto data (rtP)
    ;%
      section.nData     = 15;
      section.data(15)  = dumData; %prealloc
      
	  ;% rtP.C
	  section.data(1).logicalSrcIdx = 0;
	  section.data(1).dtTransOffset = 0;
	
	  ;% rtP.L
	  section.data(2).logicalSrcIdx = 1;
	  section.data(2).dtTransOffset = 10;
	
	  ;% rtP.V
	  section.data(3).logicalSrcIdx = 2;
	  section.data(3).dtTransOffset = 20;
	
	  ;% rtP.deadzone_u
	  section.data(4).logicalSrcIdx = 3;
	  section.data(4).dtTransOffset = 45;
	
	  ;% rtP.saturation_u
	  section.data(5).logicalSrcIdx = 4;
	  section.data(5).dtTransOffset = 46;
	
	  ;% rtP.tc
	  section.data(6).logicalSrcIdx = 5;
	  section.data(6).dtTransOffset = 47;
	
	  ;% rtP.x0
	  section.data(7).logicalSrcIdx = 6;
	  section.data(7).dtTransOffset = 48;
	
	  ;% rtP.Sensornoise_seed
	  section.data(8).logicalSrcIdx = 7;
	  section.data(8).dtTransOffset = 53;
	
	  ;% rtP.Processnoise_seed
	  section.data(9).logicalSrcIdx = 8;
	  section.data(9).dtTransOffset = 54;
	
	  ;% rtP.FilterController_C
	  section.data(10).logicalSrcIdx = 9;
	  section.data(10).dtTransOffset = 55;
	
	  ;% rtP.FilterController_InitialCondition
	  section.data(11).logicalSrcIdx = 10;
	  section.data(11).dtTransOffset = 85;
	
	  ;% rtP.WhiteNoise_Mean
	  section.data(12).logicalSrcIdx = 11;
	  section.data(12).dtTransOffset = 86;
	
	  ;% rtP.WhiteNoise_StdDev
	  section.data(13).logicalSrcIdx = 12;
	  section.data(13).dtTransOffset = 87;
	
	  ;% rtP.WhiteNoise_Mean_jbwmptnndg
	  section.data(14).logicalSrcIdx = 13;
	  section.data(14).dtTransOffset = 88;
	
	  ;% rtP.WhiteNoise_StdDev_gil0pjs1r0
	  section.data(15).logicalSrcIdx = 14;
	  section.data(15).dtTransOffset = 89;
	
      nTotData = nTotData + section.nData;
      paramMap.sections(1) = section;
      clear section
      
    
      ;%
      ;% Non-auto Data (parameter)
      ;%
    

    ;%
    ;% Add final counts to struct.
    ;%
    paramMap.nTotData = nTotData;
    


  ;%**************************
  ;% Create Block Output Map *
  ;%**************************
      
    nTotData      = 0; %add to this count as we go
    nTotSects     = 1;
    sectIdxOffset = 0;
    
    ;%
    ;% Define dummy sections & preallocate arrays
    ;%
    dumSection.nData = -1;  
    dumSection.data  = [];
    
    dumData.logicalSrcIdx = -1;
    dumData.dtTransOffset = -1;
    
    ;%
    ;% Init/prealloc sigMap
    ;%
    sigMap.nSections           = nTotSects;
    sigMap.sectIdxOffset       = sectIdxOffset;
      sigMap.sections(nTotSects) = dumSection; %prealloc
    sigMap.nTotData            = -1;
    
    ;%
    ;% Auto data (rtB)
    ;%
      section.nData     = 10;
      section.data(10)  = dumData; %prealloc
      
	  ;% rtB.hf03wwvg4y
	  section.data(1).logicalSrcIdx = 0;
	  section.data(1).dtTransOffset = 0;
	
	  ;% rtB.fj1kgzlwxo
	  section.data(2).logicalSrcIdx = 1;
	  section.data(2).dtTransOffset = 1;
	
	  ;% rtB.llt4m2mj32
	  section.data(3).logicalSrcIdx = 2;
	  section.data(3).dtTransOffset = 7;
	
	  ;% rtB.aqt01x2wia
	  section.data(4).logicalSrcIdx = 3;
	  section.data(4).dtTransOffset = 8;
	
	  ;% rtB.mc4nvtgkuz
	  section.data(5).logicalSrcIdx = 4;
	  section.data(5).dtTransOffset = 9;
	
	  ;% rtB.pymeihwtkd
	  section.data(6).logicalSrcIdx = 5;
	  section.data(6).dtTransOffset = 11;
	
	  ;% rtB.g0pxyhjufo
	  section.data(7).logicalSrcIdx = 6;
	  section.data(7).dtTransOffset = 16;
	
	  ;% rtB.lj23mto5sg
	  section.data(8).logicalSrcIdx = 7;
	  section.data(8).dtTransOffset = 18;
	
	  ;% rtB.kdi2evssze
	  section.data(9).logicalSrcIdx = 8;
	  section.data(9).dtTransOffset = 20;
	
	  ;% rtB.c2etqfm0d3
	  section.data(10).logicalSrcIdx = 9;
	  section.data(10).dtTransOffset = 25;
	
      nTotData = nTotData + section.nData;
      sigMap.sections(1) = section;
      clear section
      
    
      ;%
      ;% Non-auto Data (signal)
      ;%
    

    ;%
    ;% Add final counts to struct.
    ;%
    sigMap.nTotData = nTotData;
    


  ;%*******************
  ;% Create DWork Map *
  ;%*******************
      
    nTotData      = 0; %add to this count as we go
    nTotSects     = 4;
    sectIdxOffset = 1;
    
    ;%
    ;% Define dummy sections & preallocate arrays
    ;%
    dumSection.nData = -1;  
    dumSection.data  = [];
    
    dumData.logicalSrcIdx = -1;
    dumData.dtTransOffset = -1;
    
    ;%
    ;% Init/prealloc dworkMap
    ;%
    dworkMap.nSections           = nTotSects;
    dworkMap.sectIdxOffset       = sectIdxOffset;
      dworkMap.sections(nTotSects) = dumSection; %prealloc
    dworkMap.nTotData            = -1;
    
    ;%
    ;% Auto data (rtDW)
    ;%
      section.nData     = 2;
      section.data(2)  = dumData; %prealloc
      
	  ;% rtDW.dkn4fg52aj
	  section.data(1).logicalSrcIdx = 0;
	  section.data(1).dtTransOffset = 0;
	
	  ;% rtDW.cmwdnci4fp
	  section.data(2).logicalSrcIdx = 1;
	  section.data(2).dtTransOffset = 1;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(1) = section;
      clear section
      
      section.nData     = 7;
      section.data(7)  = dumData; %prealloc
      
	  ;% rtDW.e53ltkhquw.LoggedData
	  section.data(1).logicalSrcIdx = 2;
	  section.data(1).dtTransOffset = 0;
	
	  ;% rtDW.nmposngjsj.LoggedData
	  section.data(2).logicalSrcIdx = 3;
	  section.data(2).dtTransOffset = 1;
	
	  ;% rtDW.kblfnc4axa.LoggedData
	  section.data(3).logicalSrcIdx = 4;
	  section.data(3).dtTransOffset = 3;
	
	  ;% rtDW.a2qe00s2c4.LoggedData
	  section.data(4).logicalSrcIdx = 5;
	  section.data(4).dtTransOffset = 4;
	
	  ;% rtDW.grbgwcl0c1.LoggedData
	  section.data(5).logicalSrcIdx = 6;
	  section.data(5).dtTransOffset = 5;
	
	  ;% rtDW.a4xqeoyrdf.LoggedData
	  section.data(6).logicalSrcIdx = 7;
	  section.data(6).dtTransOffset = 6;
	
	  ;% rtDW.g4l2r4ejzc.LoggedData
	  section.data(7).logicalSrcIdx = 8;
	  section.data(7).dtTransOffset = 7;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(2) = section;
      clear section
      
      section.nData     = 2;
      section.data(2)  = dumData; %prealloc
      
	  ;% rtDW.adzig2ij22
	  section.data(1).logicalSrcIdx = 9;
	  section.data(1).dtTransOffset = 0;
	
	  ;% rtDW.o12rynloaq
	  section.data(2).logicalSrcIdx = 10;
	  section.data(2).dtTransOffset = 1;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(3) = section;
      clear section
      
      section.nData     = 2;
      section.data(2)  = dumData; %prealloc
      
	  ;% rtDW.jeegs1ty2y
	  section.data(1).logicalSrcIdx = 11;
	  section.data(1).dtTransOffset = 0;
	
	  ;% rtDW.ms0qcgqyqt
	  section.data(2).logicalSrcIdx = 12;
	  section.data(2).dtTransOffset = 1;
	
      nTotData = nTotData + section.nData;
      dworkMap.sections(4) = section;
      clear section
      
    
      ;%
      ;% Non-auto Data (dwork)
      ;%
    

    ;%
    ;% Add final counts to struct.
    ;%
    dworkMap.nTotData = nTotData;
    


  ;%
  ;% Add individual maps to base struct.
  ;%

  targMap.paramMap  = paramMap;    
  targMap.signalMap = sigMap;
  targMap.dworkMap  = dworkMap;
  
  ;%
  ;% Add checksums to base struct.
  ;%


  targMap.checksum0 = 4012338573;
  targMap.checksum1 = 4251839847;
  targMap.checksum2 = 452829803;
  targMap.checksum3 = 1755867169;

