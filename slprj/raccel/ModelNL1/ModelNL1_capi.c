#include "__cf_ModelNL1.h"
#include "rtw_capi.h"
#ifdef HOST_CAPI_BUILD
#include "ModelNL1_capi_host.h"
#define sizeof(s) ((size_t)(0xFFFF))
#undef rt_offsetof
#define rt_offsetof(s,el) ((uint16_T)(0xFFFF))
#define TARGET_CONST
#define TARGET_STRING(s) (s)    
#else
#include "builtin_typeid_types.h"
#include "ModelNL1.h"
#include "ModelNL1_capi.h"
#include "ModelNL1_private.h"
#ifdef LIGHT_WEIGHT_CAPI
#define TARGET_CONST                  
#define TARGET_STRING(s)               (NULL)                    
#else
#define TARGET_CONST                   const
#define TARGET_STRING(s)               (s)
#endif
#endif
static const rtwCAPI_Signals rtBlockSignals [ ] = { { 0 , 0 , TARGET_STRING (
"ModelNL1/Clock" ) , TARGET_STRING ( "" ) , 0 , 0 , 0 , 0 , 0 } , { 1 , 0 ,
TARGET_STRING ( "ModelNL1/Dead Zone" ) , TARGET_STRING ( "" ) , 0 , 0 , 0 , 0
, 0 } , { 2 , 0 , TARGET_STRING ( "ModelNL1/Saturation " ) , TARGET_STRING (
"" ) , 0 , 0 , 0 , 0 , 0 } , { 3 , 0 , TARGET_STRING (
"ModelNL1/Linear Observer + Controller/Filter + Controller" ) , TARGET_STRING
( "" ) , 0 , 0 , 1 , 0 , 0 } , { 4 , 0 , TARGET_STRING (
"ModelNL1/Nonlinear Dynamics/C" ) , TARGET_STRING ( "" ) , 0 , 0 , 2 , 0 , 0
} , { 5 , 0 , TARGET_STRING ( "ModelNL1/Nonlinear Dynamics/Integrator" ) ,
TARGET_STRING ( "" ) , 0 , 0 , 3 , 0 , 0 } , { 6 , 0 , TARGET_STRING (
"ModelNL1/Nonlinear Dynamics/Sum1" ) , TARGET_STRING ( "" ) , 0 , 0 , 3 , 0 ,
0 } , { 7 , 0 , TARGET_STRING ( "ModelNL1/Nonlinear Dynamics/Sum2" ) ,
TARGET_STRING ( "" ) , 0 , 0 , 2 , 0 , 0 } , { 8 , 0 , TARGET_STRING (
"ModelNL1/Nonlinear Dynamics/Process noise/Output" ) , TARGET_STRING ( "" ) ,
0 , 0 , 3 , 0 , 1 } , { 9 , 0 , TARGET_STRING (
"ModelNL1/Nonlinear Dynamics/Sensor noise/Output" ) , TARGET_STRING ( "" ) ,
0 , 0 , 2 , 0 , 1 } , { 0 , 0 , ( NULL ) , ( NULL ) , 0 , 0 , 0 , 0 , 0 } } ;
static const rtwCAPI_BlockParameters rtBlockParameters [ ] = { { 10 ,
TARGET_STRING ( "ModelNL1/Linear Observer + Controller/Filter + Controller" )
, TARGET_STRING ( "C" ) , 0 , 4 , 0 } , { 11 , TARGET_STRING (
"ModelNL1/Linear Observer + Controller/Filter + Controller" ) , TARGET_STRING
( "InitialCondition" ) , 0 , 0 , 0 } , { 12 , TARGET_STRING (
"ModelNL1/Nonlinear Dynamics/Process noise" ) , TARGET_STRING ( "seed" ) , 0
, 0 , 0 } , { 13 , TARGET_STRING ( "ModelNL1/Nonlinear Dynamics/Sensor noise"
) , TARGET_STRING ( "seed" ) , 0 , 0 , 0 } , { 14 , TARGET_STRING (
"ModelNL1/Nonlinear Dynamics/Process noise/White Noise" ) , TARGET_STRING (
"Mean" ) , 0 , 0 , 0 } , { 15 , TARGET_STRING (
"ModelNL1/Nonlinear Dynamics/Process noise/White Noise" ) , TARGET_STRING (
"StdDev" ) , 0 , 0 , 0 } , { 16 , TARGET_STRING (
"ModelNL1/Nonlinear Dynamics/Sensor noise/White Noise" ) , TARGET_STRING (
"Mean" ) , 0 , 0 , 0 } , { 17 , TARGET_STRING (
"ModelNL1/Nonlinear Dynamics/Sensor noise/White Noise" ) , TARGET_STRING (
"StdDev" ) , 0 , 0 , 0 } , { 0 , ( NULL ) , ( NULL ) , 0 , 0 , 0 } } ; static
const rtwCAPI_ModelParameters rtModelParameters [ ] = { { 18 , TARGET_STRING
( "C" ) , 0 , 5 , 0 } , { 19 , TARGET_STRING ( "L" ) , 0 , 6 , 0 } , { 20 ,
TARGET_STRING ( "V" ) , 0 , 7 , 0 } , { 21 , TARGET_STRING ( "deadzone_u" ) ,
0 , 0 , 0 } , { 22 , TARGET_STRING ( "saturation_u" ) , 0 , 0 , 0 } , { 23 ,
TARGET_STRING ( "tc" ) , 0 , 0 , 0 } , { 24 , TARGET_STRING ( "x0" ) , 0 , 3
, 0 } , { 0 , ( NULL ) , 0 , 0 , 0 } } ;
#ifndef HOST_CAPI_BUILD
static void * rtDataAddrMap [ ] = { & rtB . hf03wwvg4y , & rtB . aqt01x2wia ,
& rtB . llt4m2mj32 , & rtB . fj1kgzlwxo [ 0 ] , & rtB . g0pxyhjufo [ 0 ] , &
rtB . pymeihwtkd [ 0 ] , & rtB . c2etqfm0d3 [ 0 ] , & rtB . lj23mto5sg [ 0 ]
, & rtB . kdi2evssze [ 0 ] , & rtB . mc4nvtgkuz [ 0 ] , & rtP .
FilterController_C [ 0 ] , & rtP . FilterController_InitialCondition , & rtP
. Processnoise_seed , & rtP . Sensornoise_seed , & rtP .
WhiteNoise_Mean_jbwmptnndg , & rtP . WhiteNoise_StdDev_gil0pjs1r0 , & rtP .
WhiteNoise_Mean , & rtP . WhiteNoise_StdDev , & rtP . C [ 0 ] , & rtP . L [ 0
] , & rtP . V [ 0 ] , & rtP . deadzone_u , & rtP . saturation_u , & rtP . tc
, & rtP . x0 [ 0 ] , } ; static int32_T * rtVarDimsAddrMap [ ] = { ( NULL ) }
;
#endif
static TARGET_CONST rtwCAPI_DataTypeMap rtDataTypeMap [ ] = { { "double" ,
"real_T" , 0 , 0 , sizeof ( real_T ) , SS_DOUBLE , 0 , 0 } } ;
#ifdef HOST_CAPI_BUILD
#undef sizeof
#endif
static TARGET_CONST rtwCAPI_ElementMap rtElementMap [ ] = { { ( NULL ) , 0 ,
0 , 0 , 0 } , } ; static const rtwCAPI_DimensionMap rtDimensionMap [ ] = { {
rtwCAPI_SCALAR , 0 , 2 , 0 } , { rtwCAPI_VECTOR , 2 , 2 , 0 } , {
rtwCAPI_VECTOR , 4 , 2 , 0 } , { rtwCAPI_VECTOR , 6 , 2 , 0 } , {
rtwCAPI_MATRIX_COL_MAJOR , 8 , 2 , 0 } , { rtwCAPI_MATRIX_COL_MAJOR , 10 , 2
, 0 } , { rtwCAPI_MATRIX_COL_MAJOR , 12 , 2 , 0 } , {
rtwCAPI_MATRIX_COL_MAJOR , 14 , 2 , 0 } } ; static const uint_T
rtDimensionArray [ ] = { 1 , 1 , 6 , 1 , 2 , 1 , 5 , 1 , 6 , 5 , 2 , 5 , 5 ,
2 , 5 , 5 } ; static const real_T rtcapiStoredFloats [ ] = { 0.0 ,
8.52535319834408E-5 } ; static const rtwCAPI_FixPtMap rtFixPtMap [ ] = { { (
NULL ) , ( NULL ) , rtwCAPI_FIX_RESERVED , 0 , 0 , 0 } , } ; static const
rtwCAPI_SampleTimeMap rtSampleTimeMap [ ] = { { ( const void * ) &
rtcapiStoredFloats [ 0 ] , ( const void * ) & rtcapiStoredFloats [ 0 ] , 0 ,
0 } , { ( const void * ) & rtcapiStoredFloats [ 1 ] , ( const void * ) &
rtcapiStoredFloats [ 0 ] , 1 , 0 } } ; static rtwCAPI_ModelMappingStaticInfo
mmiStatic = { { rtBlockSignals , 10 , ( NULL ) , 0 , ( NULL ) , 0 } , {
rtBlockParameters , 8 , rtModelParameters , 7 } , { ( NULL ) , 0 } , {
rtDataTypeMap , rtDimensionMap , rtFixPtMap , rtElementMap , rtSampleTimeMap
, rtDimensionArray } , "float" , { 4012338573U , 4251839847U , 452829803U ,
1755867169U } , ( NULL ) , 0 , 0 } ; const rtwCAPI_ModelMappingStaticInfo *
ModelNL1_GetCAPIStaticMap ( void ) { return & mmiStatic ; }
#ifndef HOST_CAPI_BUILD
void ModelNL1_InitializeDataMapInfo ( void ) { rtwCAPI_SetVersion ( ( *
rt_dataMapInfoPtr ) . mmi , 1 ) ; rtwCAPI_SetStaticMap ( ( *
rt_dataMapInfoPtr ) . mmi , & mmiStatic ) ; rtwCAPI_SetLoggingStaticMap ( ( *
rt_dataMapInfoPtr ) . mmi , ( NULL ) ) ; rtwCAPI_SetDataAddressMap ( ( *
rt_dataMapInfoPtr ) . mmi , rtDataAddrMap ) ; rtwCAPI_SetVarDimsAddressMap (
( * rt_dataMapInfoPtr ) . mmi , rtVarDimsAddrMap ) ;
rtwCAPI_SetInstanceLoggingInfo ( ( * rt_dataMapInfoPtr ) . mmi , ( NULL ) ) ;
rtwCAPI_SetChildMMIArray ( ( * rt_dataMapInfoPtr ) . mmi , ( NULL ) ) ;
rtwCAPI_SetChildMMIArrayLen ( ( * rt_dataMapInfoPtr ) . mmi , 0 ) ; }
#else
#ifdef __cplusplus
extern "C" {
#endif
void ModelNL1_host_InitializeDataMapInfo ( ModelNL1_host_DataMapInfo_T *
dataMap , const char * path ) { rtwCAPI_SetVersion ( dataMap -> mmi , 1 ) ;
rtwCAPI_SetStaticMap ( dataMap -> mmi , & mmiStatic ) ;
rtwCAPI_SetDataAddressMap ( dataMap -> mmi , NULL ) ;
rtwCAPI_SetVarDimsAddressMap ( dataMap -> mmi , NULL ) ; rtwCAPI_SetPath (
dataMap -> mmi , path ) ; rtwCAPI_SetFullPath ( dataMap -> mmi , NULL ) ;
rtwCAPI_SetChildMMIArray ( dataMap -> mmi , ( NULL ) ) ;
rtwCAPI_SetChildMMIArrayLen ( dataMap -> mmi , 0 ) ; }
#ifdef __cplusplus
}
#endif
#endif
