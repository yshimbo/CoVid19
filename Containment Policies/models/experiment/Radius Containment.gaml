/***
* Name: Corona
* Author: hqngh
* Description: 
* Tags: Tag1, Tag2, TagN
***/
model Corona

import "../Global.gaml"
import "../species/Policy.gaml"
import "Abstract.gaml"

global {

	init {  
		do global_init;
		do create_authority;
		ask Authority {
			loop i over: Individual where (each.status=infected){				
				policies << createQuarantinePolicyAtRadius(i.location, 200#m);
			}
		}

	}

}

experiment "Radius Quarantine" parent: "Abstract Experiment" {
	output {
		display "Main" parent: d1 {
		}

	}

}