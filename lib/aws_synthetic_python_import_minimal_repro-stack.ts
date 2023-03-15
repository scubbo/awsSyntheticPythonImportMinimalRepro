import * as cdk from 'aws-cdk-lib';
import { Construct } from 'constructs';
import {Canary, Code, Runtime, Schedule, Test} from "@aws-cdk/aws-synthetics-alpha";
import {Duration} from "aws-cdk-lib";


export class AwsSyntheticPythonImportMinimalReproStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    new Canary(this, 'MinimalReproCanary', {
      schedule: Schedule.rate(Duration.hours(1)),
      test: Test.custom({
        code: Code.fromAsset("./packaged-synthetic.zip"),
        handler: 'synthetic.handler'
      }),
      runtime: Runtime.SYNTHETICS_PYTHON_SELENIUM_1_3
    });
  }
}
