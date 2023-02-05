"""The Python implementation of the GRPC access_measurements.Getter and Setter client."""

from __future__ import print_function

import logging

import access_measurements_pb2
import access_measurements_pb2_grpc
import grpc


def run():
    # Demonstration on how to use the setValue and getValue methods
    with grpc.insecure_channel("localhost:50051") as channel:
        stub = access_measurements_pb2_grpc.SetGetterStub(channel)

        # change code here ________________________________________________________
        response = stub.GetAngleHzRad(access_measurements_pb2.GetRequest())
        print("Horizontal angle received: ", response.value)
        response = stub.GetAngleVRad(access_measurements_pb2.GetRequest())
        print("Vertical angle received: ", response.value)
        response = stub.GetDistSlope(access_measurements_pb2.GetRequest())
        print("Distance received: ", response.value)

        response = stub.SetAngleHzRad(access_measurements_pb2.SetRequest(value=0.4))
        print("Horizontal angle set: ", response.value)
        response = stub.SetAngleVRad(access_measurements_pb2.SetRequest(value=0.2))
        print("Vertical angle set: ", response.value)
        response = stub.SetDistSlope(access_measurements_pb2.SetRequest(value=2))
        print("Distance set: ", response.value)
        # __________________________________________________________________________


if __name__ == "__main__":
    logging.basicConfig()
    run()
