// =====================================================================================
//  
// ChModuleVehicle.i
// Create the Python and C# wrappers for the Chrono::Vehicle module.
//
// ATTENTION: 
// Must be included from another SWIG interface file which defines the module.
//
// =====================================================================================

// Turn on the documentation of members, for more intuitive IDE typing
%feature("autodoc", "1");
%feature("flatnested", "1");

// Turn on the exception handling to intercept C++ exceptions
%include "exception.i"

%exception {
  try {
    $action
  } catch (const std::exception& e) {
    SWIG_exception(SWIG_RuntimeError, e.what());
  }
}


// For optional casting of polimorphic objects:
%include "../chrono_cast.i" 
%include "../chrono_ignore_operators.i"

// For supporting shared pointers:
%include <std_shared_ptr.i>
%{
#include <string>
#include <vector>

#include "chrono/core/ChQuaternion.h"
#include "chrono/core/ChVector2.h"
#include "chrono/core/ChVector3.h"
#include "chrono/core/ChCoordsys.h"
#include "chrono/core/ChFrame.h"

#include "chrono/functions/ChFunction.h"
#include "chrono/functions/ChFunctionPosition.h"
#include "chrono/functions/ChFunctionPositionLine.h"
#include "chrono/functions/ChFunctionPositionSetpoint.h"
#include "chrono/functions/ChFunctionPositionXYZFunctions.h"
#include "chrono/functions/ChFunctionRotationABCFunctions.h"
#include "chrono/functions/ChFunctionRotation.h"
#include "chrono/functions/ChFunctionRotationAxis.h"
#include "chrono/functions/ChFunctionRotationBSpline.h"
#include "chrono/functions/ChFunctionRotationSetpoint.h"
#include "chrono/functions/ChFunctionRotationSQUAD.h"

#include "chrono/solver/ChSolver.h"

#include "chrono/physics/ChSystem.h"
#include "chrono/physics/ChShaft.h"
#include "chrono/physics/ChShaftsLoads.h"
#include "chrono/physics/ChShaftsFreewheel.h"
#include "chrono/physics/ChShaftsAppliedTorque.h"
#include "chrono/physics/ChMarker.h"
#include "chrono/physics/ChLink.h"
#include "chrono/physics/ChShaftsCouple.h"
#include "chrono/physics/ChLinkTSDA.h"
#include "chrono/physics/ChLinkRSDA.h"
#include "chrono/physics/ChLoadsBody.h"
#include "chrono/physics/ChLoadsNodeXYZ.h"
#include "chrono/physics/ChLoadHydrodynamics.h"
#include "chrono/physics/ChPhysicsItem.h"

#include "chrono/geometry/ChTriangleMeshConnected.h"
#include "chrono/assets/ChVisualShapes.h"

#include "chrono/fea/ChMesh.h"

#include "chrono/input_output/ChOutput.h"
#include "chrono/input_output/ChCheckpoint.h"

#include "chrono/collision/ChCollisionModel.h"
#include "chrono/collision/ChCollisionSystem.h"

#include "chrono_vehicle/ChApiVehicle.h"
#include "chrono_vehicle/ChVehicle.h"
#include "chrono_vehicle/ChSubsysDefs.h"
#include "chrono_vehicle/ChVehicleDataPath.h"
#include "chrono_vehicle/ChChassis.h"
#include "chrono_vehicle/ChPart.h"
#include "chrono_vehicle/ChWorldFrame.h"

#include "chrono_vehicle/ChPowertrainAssembly.h"

#include "chrono_vehicle/ChDriver.h"
#include "chrono_vehicle/ChTerrain.h"
// moved up the file order to ensure this is included in this group - otherwise a build without irrlicht/vsg fails
#include "chrono_vehicle/ChVehicleVisualSystem.h"

// Wheeled vehicle
#include "chrono_vehicle/wheeled_vehicle/ChWheeledVehicle.h"
#include "chrono_vehicle/wheeled_vehicle/ChWheeledTrailer.h"
#include "chrono_vehicle/wheeled_vehicle/vehicle/WheeledVehicle.h"
#include "chrono_vehicle/wheeled_vehicle/vehicle/WheeledTrailer.h"

#include "chrono_vehicle/wheeled_vehicle/ChWheel.h"
#include "chrono_vehicle/wheeled_vehicle/wheel/Wheel.h"

#include "chrono_vehicle/wheeled_vehicle/ChAxle.h"

#include "chrono_vehicle/wheeled_vehicle/ChSpindle.h"
#include "chrono_vehicle/wheeled_vehicle/ChBrake.h"
#include "chrono_vehicle/wheeled_vehicle/brake/ChBrakeSimple.h"
#include "chrono_vehicle/wheeled_vehicle/brake/ChBrakeShafts.h"
#include "chrono_vehicle/wheeled_vehicle/brake/BrakeSimple.h"
#include "chrono_vehicle/wheeled_vehicle/brake/BrakeShafts.h"

#include "chrono_vehicle/wheeled_vehicle/test_rig/ChSuspensionTestRig.h"
#include "chrono_vehicle/wheeled_vehicle/test_rig/ChWheelTestRig.h"

// Tracked vehicle
#include "chrono_vehicle/tracked_vehicle/ChTrackedVehicle.h"
#include "chrono_vehicle/tracked_vehicle/vehicle/TrackedVehicle.h"

#include "chrono_vehicle/tracked_vehicle/ChIdler.h"
#include "chrono_vehicle/tracked_vehicle/ChTrackWheel.h"
#include "chrono_vehicle/tracked_vehicle/ChTrackSuspension.h"
#include "chrono_vehicle/tracked_vehicle/ChTrackShoe.h"

#include "chrono_vehicle/tracked_vehicle/ChTrackBrake.h"
#include "chrono_vehicle/tracked_vehicle/brake/ChTrackBrakeSimple.h"
#include "chrono_vehicle/tracked_vehicle/brake/ChTrackBrakeShafts.h"
#include "chrono_vehicle/tracked_vehicle/brake/TrackBrakeSimple.h"
#include "chrono_vehicle/tracked_vehicle/brake/TrackBrakeShafts.h"

#include "chrono_vehicle/tracked_vehicle/ChTrackContactManager.h"

#include "chrono_thirdparty/rapidjson/document.h"

using namespace chrono;
using namespace chrono::fea;
using namespace chrono::vehicle;
%}
// Undefine ChApi otherwise SWIG gives a syntax error
#define CH_VEHICLE_API 

#ifdef SWIGPYTHON  // --------------------------------------------------------------------- PYTHON
#ifdef CHRONO_FSI_SPH
#define CH_FSI_API
#endif
#endif             // --------------------------------------------------------------------- PYTHON

#define ChApi
#define EIGEN_MAKE_ALIGNED_OPERATOR_NEW
#define CH_DEPRECATED(msg)
#define CH_MODELS_API

// workaround for trouble
//%ignore chrono::fea::ChContactNodeXYZ::ComputeJacobianForContactPart;

// Include other .i configuration files for SWIG. 
%include "std_string.i"
%include "std_vector.i"
%include "std_pair.i"
%include "typemaps.i"
#ifdef SWIGPYTHON  // --------------------------------------------------------------------- PYTHON
%include "cstring.i"
#endif             // --------------------------------------------------------------------- PYTHON
%include "cpointer.i"

#ifdef SWIGPYTHON  // --------------------------------------------------------------------- PYTHON
%include "std_wstring.i"
%include "wchar.i"
%include "python/cwstring.i"
#endif             // --------------------------------------------------------------------- PYTHON

// A- ENABLE SHARED POINTERS
//
// Note that this must be done for almost all objects (not only those that are
// handled by shered pointers in C++, but all their chidren and parent classes. It
// is enough that a single class in an inheritance tree uses %shared_ptr, and all other in the 
// tree must be promoted to %shared_ptr too).

//from core module:
%shared_ptr(chrono::ChFrame<double>) 
%shared_ptr(chrono::ChFrameMoving<double>)
%shared_ptr(chrono::ChPhysicsItem)
%shared_ptr(chrono::ChNodeBase) 
%shared_ptr(chrono::ChNodeXYZ) 
%shared_ptr(chrono::ChVisualShapeTriangleMesh)
%shared_ptr(chrono::ChTriangleMeshConnected)
%shared_ptr(chrono::ChBezierCurve)
%shared_ptr(chrono::ChLinkMarkers)
%shared_ptr(chrono::ChContactable)
%shared_ptr(chrono::ChContactable_1vars)
%shared_ptr(chrono::ChContactable_2vars)
%shared_ptr(chrono::ChContactable_3vars)
%shared_ptr(chrono::fea::ChMesh)

%shared_ptr(chrono::ChCollisionModel)
%shared_ptr(chrono::ChCollisionSystem::BroadphaseCallback)
%shared_ptr(chrono::ChCollisionSystem::NarrowphaseCallback)

#ifdef SWIGPYTHON  // --------------------------------------------------------------------- PYTHON
#ifdef CHRONO_FSI_SPH
%shared_ptr(chrono::vehicle::CRMTerrain)
#endif
#endif             // --------------------------------------------------------------------- PYTHON

// ChTerrain.i imports most pychrono.core types it needs, but ChClassFactory.h
// must be imported first because it defines macros used by the terrain headers.
%import(module = "pychrono.core") "chrono_swig/interface/core/ChClassFactory.i"

#ifdef SWIGPYTHON

#ifdef CHRONO_FSI_SPH
%import(module = "pychrono.fsi") "chrono_swig/interface/fsi/ChFsiProblemSPH.i"
#endif
#endif             // --------------------------------------------------------------------- PYTHON


// Only the terrain API is needed by this project; CRMTerrain lives here.
// TODO: 
//%include "rapidjson.i"
//%include "../../../chrono_vehicle/ChApiVehicle.h"
%ignore chrono::vehicle::VehicleCollisionFamily::Enum;
%ignore chrono::vehicle::TrackedCollisionFlag::Enum;
%ignore chrono::vehicle::OutputInformation;
%ignore chrono::vehicle::VehiclePartTag;
%include "../../../chrono_vehicle/ChSubsysDefs.h"
%template(vector_int) std::vector<int>;
%template(vector_double) std::vector<double>;
%template(TerrainForces) std::vector<chrono::vehicle::TerrainForce>;
%include "ChTerrain.i"
