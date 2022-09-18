# Simulator access with a gRPC interface
This folder includes a gRPC server to set and get horizontal angle (AngleHz), set and get vertical angle (AngleV) and slope distance in meter (DistSlope) in the Leica Captivate simulator.

## Required dependencies
  - pip install grpcio
  - pip install protobuf

## Folder content
| File | Description |
| ---- | ----------- |
| access_client.py | example for client implementation |
| access_measurements.proto | gRPC interface definition |
| access_measurements_pb2.py | generated Python file |
| access_measurements_pb2_grpc.py| generated Python file |
| access_server.py | server implementation |

## List of all functions:
  - GetAngleHzRad ( access_measurements_pb2.GetRequest() ) <br>
  - GetAngleVRad ( access_measurements_pb2.GetRequest() ) <br>
  - GetDistSlope ( access_measurements_pb2.GetRequest() ) <br>
  - SetAngleHzRad ( access_measurements_pb2.SetRequest ( value = XXX ) ) <br>
  - SetAngleVRad ( access_measurements_pb2.SetRequest ( value = XXX ) ) <br>
  - SetDistSlope ( access_measurements_pb2.SetRequest ( value = XXX ) ) <br>

## Instructions:
  - The `access_server` and `access_measurements.proto` files can be used via `access_client` to call these functions.

### Python
  - If python is used, the other files `access_measurements_pb2.py`, `access_measurements_pb2_grpc.py` and an example `access_client.py` are already generated. The user can modify `access_client.py` directly and add or change functions as needed.

### Other programming language
  - If other language is preferred, the user must create their own pb2 files from the proto file and implement the client differently.

## Alternatives:
  - It is possible to avoid working with grpc and execute command prompts directly in the code. <br>
  Get value: `REG QUERY "HKCU\SOFTWARE\Leica Geosystems\System 1500\TS\Settings" /v AngleHz"` <br>
  Set value: `REG ADD "HKCU\SOFTWARE\Leica Geosystems\System 1500\TS\Settings" /t REG_SZ /v AngleHz /d XXX /f` <br>
  - Example for python: <br>

**GetAngleHzRad:**
    
```python
    import os 
    stream = os.popen('REG QUERY "HKCU\SOFTWARE\Leica Geosystems\System 1500\TS\Settings" /v AngleHz"')
    output = stream.read()
    vallist = output.split(" ")
    result = float(vallist[-1])
    
    # Replace AngleHz with current name
```  
  
**SetAngleHzRad:**

```python
    import os
    os.popen('REG ADD "HKCU\SOFTWARE\Leica Geosystems\System 1500\TS\Settings" /t REG_SZ /v AngleHz /d XXX /f')
    
    # Replace the 'XXX' with value to set and AngleHz with current name
```
