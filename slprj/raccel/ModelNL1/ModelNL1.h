#include "__cf_ModelNL1.h"
#ifndef RTW_HEADER_ModelNL1_h_
#define RTW_HEADER_ModelNL1_h_
#include <stddef.h>
#include <string.h>
#include "rtw_modelmap.h"
#ifndef ModelNL1_COMMON_INCLUDES_
#define ModelNL1_COMMON_INCLUDES_
#include <stdlib.h>
#include "rtwtypes.h"
#include "simtarget/slSimTgtSigstreamRTW.h"
#include "simtarget/slSimTgtSlioCoreRTW.h"
#include "simtarget/slSimTgtSlioClientsRTW.h"
#include "simtarget/slSimTgtSlioSdiRTW.h"
#include "sigstream_rtw.h"
#include "simstruc.h"
#include "fixedpoint.h"
#include "raccel.h"
#include "slsv_diagnostic_codegen_c_api.h"
#include "rt_logging.h"
#include "dt_info.h"
#include "ext_work.h"
#endif
#include "ModelNL1_types.h"
#include "multiword_types.h"
#include "mwmathutil.h"
#include "rt_defines.h"
#include "rtGetInf.h"
#include "rt_nonfinite.h"
#define MODEL_NAME ModelNL1
#define NSAMPLE_TIMES (2) 
#define NINPUTS (0)       
#define NOUTPUTS (0)     
#define NBLOCKIO (10) 
#define NUM_ZC_EVENTS (0) 
#ifndef NCSTATES
#define NCSTATES (10)   
#elif NCSTATES != 10
#error Invalid specification of NCSTATES defined in compiler command
#endif
#ifndef rtmGetDataMapInfo
#define rtmGetDataMapInfo(rtm) (*rt_dataMapInfoPtr)
#endif
#ifndef rtmSetDataMapInfo
#define rtmSetDataMapInfo(rtm, val) (rt_dataMapInfoPtr = &val)
#endif
#ifndef IN_RACCEL_MAIN
#endif
typedef struct { real_T hf03wwvg4y ; real_T fj1kgzlwxo [ 6 ] ; real_T
llt4m2mj32 ; real_T aqt01x2wia ; real_T mc4nvtgkuz [ 2 ] ; real_T pymeihwtkd
[ 5 ] ; real_T g0pxyhjufo [ 2 ] ; real_T lj23mto5sg [ 2 ] ; real_T kdi2evssze
[ 5 ] ; real_T c2etqfm0d3 [ 5 ] ; } B ; typedef struct { real_T dkn4fg52aj ;
real_T cmwdnci4fp ; struct { void * LoggedData ; } e53ltkhquw ; struct { void
* LoggedData [ 2 ] ; } nmposngjsj ; struct { void * LoggedData ; } kblfnc4axa
; struct { void * LoggedData ; } a2qe00s2c4 ; struct { void * LoggedData ; }
grbgwcl0c1 ; struct { void * LoggedData ; } a4xqeoyrdf ; struct { void *
LoggedData ; } g4l2r4ejzc ; uint32_T adzig2ij22 ; uint32_T o12rynloaq ; int_T
jeegs1ty2y ; int_T ms0qcgqyqt ; } DW ; typedef struct { real_T c4x4tqbsqk [ 5
] ; real_T hfyhsjwpyb [ 5 ] ; } X ; typedef struct { real_T c4x4tqbsqk [ 5 ]
; real_T hfyhsjwpyb [ 5 ] ; } XDot ; typedef struct { boolean_T c4x4tqbsqk [
5 ] ; boolean_T hfyhsjwpyb [ 5 ] ; } XDis ; typedef struct { real_T
c4x4tqbsqk [ 5 ] ; real_T hfyhsjwpyb [ 5 ] ; } CStateAbsTol ; typedef struct
{ real_T eypjjfh2kj ; real_T bq32l0uslm ; real_T aqzzwpjzn0 ; real_T
kyggoqmkvl ; } ZCV ; typedef struct { real_T eawrrtojai [ 5 ] ; } ConstP ;
typedef struct { rtwCAPI_ModelMappingInfo mmi ; } DataMapInfo ; struct P_ {
real_T C [ 10 ] ; real_T L [ 10 ] ; real_T V [ 25 ] ; real_T deadzone_u ;
real_T saturation_u ; real_T tc ; real_T x0 [ 5 ] ; real_T Sensornoise_seed ;
real_T Processnoise_seed ; real_T FilterController_C [ 30 ] ; real_T
FilterController_InitialCondition ; real_T WhiteNoise_Mean ; real_T
WhiteNoise_StdDev ; real_T WhiteNoise_Mean_jbwmptnndg ; real_T
WhiteNoise_StdDev_gil0pjs1r0 ; } ; extern const char *
RT_MEMORY_ALLOCATION_ERROR ; extern B rtB ; extern X rtX ; extern DW rtDW ;
extern P rtP ; extern const ConstP rtConstP ; extern const
rtwCAPI_ModelMappingStaticInfo * ModelNL1_GetCAPIStaticMap ( void ) ; extern
SimStruct * const rtS ; extern const int_T gblNumToFiles ; extern const int_T
gblNumFrFiles ; extern const int_T gblNumFrWksBlocks ; extern rtInportTUtable
* gblInportTUtables ; extern const char * gblInportFileName ; extern const
int_T gblNumRootInportBlks ; extern const int_T gblNumModelInputs ; extern
const int_T gblInportDataTypeIdx [ ] ; extern const int_T gblInportDims [ ] ;
extern const int_T gblInportComplex [ ] ; extern const int_T
gblInportInterpoFlag [ ] ; extern const int_T gblInportContinuous [ ] ;
extern const int_T gblParameterTuningTid ; extern DataMapInfo *
rt_dataMapInfoPtr ; extern rtwCAPI_ModelMappingInfo * rt_modelMapInfoPtr ;
void MdlOutputs ( int_T tid ) ; void MdlOutputsParameterSampleTime ( int_T
tid ) ; void MdlUpdate ( int_T tid ) ; void MdlTerminate ( void ) ; void
MdlInitializeSizes ( void ) ; void MdlInitializeSampleTimes ( void ) ;
SimStruct * raccel_register_model ( void ) ;
#endif
