/***
* Name: Corona
* Author: dphilippon
* Description: 
* Tags: Tag1, Tag2, TagN
***/
model Corona

import "../Global.gaml"
import "Abstract Experiment.gaml"




experiment "Comparison" parent: "Abstract Experiment" autorun: true {

	action _init_ {
		string shape_path <- self.ask_dataset_path();
		float simulation_seed <- rnd(2000.0);
		create simulation with: [dataset::shape_path, seed::simulation_seed, transmission_building::false, transmission_human::false] {
			name <- "No viral load, no human transmission";
			ask Authority {
				policy <- create_no_containment_policy();
			}

		}

		create simulation with: [dataset::shape_path, seed::simulation_seed, transmission_building::true, transmission_human::false]{
			name <- "With viral load, no human transmission";
			ask Authority { 
				policy <- create_no_containment_policy();
			}

		}
		
		create simulation with: [dataset::shape_path, seed::simulation_seed, transmission_building::false, transmission_human::true] {
			name <- "No viral load, with human transmission";
			ask Authority {
				policy <- create_no_containment_policy();
			}

		}

		create simulation with: [dataset::shape_path, seed::simulation_seed, transmission_building::true, transmission_human::true]{
			name <- "With viral load and human transmission";
			ask Authority { 
				policy <- create_no_containment_policy();
			}

		}

	}
	
	permanent {
		
		display "charts" toolbar: false background: #black{
			chart "Infected cases" background: #black axes: #white color: #white title_font: default legend_font: font("Helvetica", 14, #bold) {
			loop s over: simulations {
				data s.name value: s.number_of_infectious color: s.color marker: false style: line thickness: 2; 
				
			}}
			graphics "title" {
				draw ("Day " + int((current_date - starting_date) /  #day))  font: default at: {100#px, 0} color:#white anchor: #top_left;
			}
		}
		
		display "Cumulative incidence" toolbar: false background: #black{
			chart "Cumulative incidence" background: #black axes: #white color: #white title_font: default legend_font: font("Helvetica", 14, #bold) {
			loop s over: simulations {
				data s.name value: s.total_number_of_infected color: s.color marker: false style: line thickness: 2; 
				
			}}
		}
	}


	output {
		layout #split consoles: false editors: false navigator: false tray: false tabs: false toolbars: false controls: false;
		display "Main" parent: default_display {}
	}

}