"""The Python implementation of the GRPC access_measurements.Getter and Setter server."""

import logging
import os
from concurrent import futures

import access_measurements_pb2
import access_measurements_pb2_grpc
import grpc


class SetGetter(access_measurements_pb2_grpc.SetGetterServicer):
    def GetAngleHzRad(self, request, context):
        cmdfunc = r'REG QUERY "HKCU\SOFTWARE\Leica Geosystems\System 1500\TS\Settings" /v AngleHz"'
        stream = os.popen(cmdfunc)
        output = stream.read()
        vallist = output.split(" ")
        return access_measurements_pb2.Reply(value=float(vallist[-1]))

    def GetAngleVRad(self, request, context):
        cmdfunc = r'REG QUERY "HKCU\SOFTWARE\Leica Geosystems\System 1500\TS\Settings" /v AngleV"'
        stream = os.popen(cmdfunc)
        output = stream.read()
        vallist = output.split(" ")
        return access_measurements_pb2.Reply(value=float(vallist[-1]))

    def GetDistSlope(self, request, context):
        cmdfunc = r'REG QUERY "HKCU\SOFTWARE\Leica Geosystems\System 1500\TS\Settings" /v DistSlope"'
        stream = os.popen(cmdfunc)
        output = stream.read()
        vallist = output.split(" ")
        return access_measurements_pb2.Reply(value=float(vallist[-1]))

    def SetAngleHzRad(self, request, context):
        cmdfunc = r'REG ADD "HKCU\SOFTWARE\Leica Geosystems\System 1500\TS\Settings" /t REG_SZ /v AngleHz /d '
        strvalue = str(round(request.value, 4))
        cmdfunc = cmdfunc + strvalue + " /f"
        os.popen(cmdfunc)
        return access_measurements_pb2.Reply(value=float(strvalue))

    def SetAngleVRad(self, request, context):
        cmdfunc = r'REG ADD "HKCU\SOFTWARE\Leica Geosystems\System 1500\TS\Settings" /t REG_SZ /v AngleV /d '
        strvalue = str(round(request.value, 4))
        cmdfunc = cmdfunc + strvalue + " /f"
        os.popen(cmdfunc)
        return access_measurements_pb2.Reply(value=float(strvalue))

    def SetDistSlope(self, request, context):
        cmdfunc = r'REG ADD "HKCU\SOFTWARE\Leica Geosystems\System 1500\TS\Settings" /t REG_SZ /v DistSlope /d '
        strvalue = str(round(request.value, 4))
        cmdfunc = cmdfunc + strvalue + " /f"
        os.popen(cmdfunc)
        return access_measurements_pb2.Reply(value=float(strvalue))


def serve():
    server = grpc.server(futures.ThreadPoolExecutor(max_workers=50))
    access_measurements_pb2_grpc.add_SetGetterServicer_to_server(SetGetter(), server)
    server.add_insecure_port("[::]:50051")
    server.start()
    server.wait_for_termination()


if __name__ == "__main__":
    logging.basicConfig()
    serve()
