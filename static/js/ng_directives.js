App.directive("visData",["IC",function(IC){
	return {
		restrict: "A",
		//templateUrl: "/testd3js/test.html",
		//template: "<div><a class='btn btn-primary' onclick='visualizeData()'>Execute</a></div>",
		// template: "<div>Hello</div>",
		controller: function($scope,$element,$location,IC) {
			console.log($element);
			(function(dOffset){
				$(window).on("scroll",function(e){
					if($(document).scrollTop()>dOffset) {
						if(!$(".data-visual").hasClass("data-affixed")) {
							$(".data-visual").addClass("data-affixed");
							// $(".column-textual").addClass("offset3");
						}
					}
					else if($(document).scrollTop()<dOffset){
						if($(".data-visual").hasClass("data-affixed")) {
							$(".data-visual").removeClass("data-affixed");
							// $(".column-textual").removeClass("offset3");
						}
					}

				});

			})($(".column-visual").offset().top)
			$scope.visualizeData = function() {
				// Clear the visual area
				// return;
				$(".data-visual").empty();

				// Define width/height
				// var width = 520,
				//    height = 520;
				var width = $element.width(),
				// var width = 1900;
				height = 300;

				//color setting util
				var color = d3.scale.category20();

				//Define the force layout and physics
				var force = d3.layout.force()
				//.friction(0.9)
				//.gravity(0.05)
				.charge(-120)
				.linkDistance(30)
				.size([width, height]);

				var lineDataSpark = [
					{x:10.239,y:20.52},
					{x:2.638,y:23.587},
					{x:7.688,y:16.457},
					{x:1.371,y:15.329},
					{x:7.954,y:11.241},
					{x:2.688,y:1.599},
					{x:10.561,y:7.012},

					{x:12.579,y:1.175},
					{x:16.284,y:7.335},
					{x:19.573,y:1.622},
					{x:20.154,y:8.098},
					{x:26.785,y:2.295},
					{x:23.058,y:8.926},
					{x:28.69,y:11.665},
					{x:22.618,y:14.259},
					{x:28.55,y:19.048},

					{x:22.485,y:19.312},
					{x:27.071,y:26.933},
					{x:19.163,y:21.662},
					{x:19.388,y:28.597},
					{x:15.033,y:24.055},
					{x:7.19,y:28.729}
				];
				var lineFunction = d3.svg.line()
					.x(function(d) { return d.x?d.x:0; })
					.y(function(d) { return d.y?d.y:0; })
					.interpolate("linear");


				(function(f){
					$(window).resize(function(){
						f.size([width,height]);
					});
				})(force);

				// Maintaining the zoom object
				var zoom = d3.behavior.zoom()
					// scaleExtent set minimum, maximum zoom
					.size(width, height)
					.scaleExtent([0.25,10]) // min, max
					.on("zoomstart", function(){
					})
					.on("zoom", function(){
						vis.attr("transform", "translate(" + d3.event.translate + ")" + " scale(" + d3.event.scale + ")");
					});

				//Create the main svg
				var svg = d3.select(".data-visual")
					.append("svg:svg")
						.attr({
							"width": "100%",
							"height": "300"
						})
						.attr("pointer-events", "all");

				var vis = svg
					.append('svg:g')
						.call(zoom)
					.append('svg:g');

				vis.append('svg:rect')
					.attr({
						"width": "100%",
						"height": "300"
					})
					.attr('fill', '#aaa'); //#aaa

				// Tooltip when hovering over nodes
				var div = d3.select("body").append("div")
						.attr("class", "tooltip")
						.style("opacity", 0);

				// var spark = d3.xml("/images/drop_spark.svg", "image/svg+xml", function(xml) {
				// });
				// console.log(spark);
				var graph = IC;
				
				//apply the data to the force layout and start
				force
					.nodes(graph.vertical)
					.links(graph.links)
					.start();

				//Draw the links
				var link = vis.selectAll(".link")
					.data(graph.links)
				.enter().append("line")
					.attr("class", "link")
					.style("stroke-width", function(d) { return Math.sqrt(d.value); });
					// .append("use")
  			// 		.attr("xlink:href","#myshape")
				//Draw the nodes
				var node = vis.selectAll(".node")
					.data(graph.vertical)
					.enter()
						.append("circle")
					// .append("use")
  					// .attr("xlink:href","#spark-svg")
					.attr("class", "node")
					.attr("r", function(d){return d.hweight+5;})
					.style("fill", function(d) {
						// color(d.group); 
						if(d.type===0) return "#ffc";
						if(d.type==1) return "#fcc";
						if(d.type==2) return "#ccf";
					})
					.style("stroke", function(d) {
						// color(d.group); 
						if(d.type===0) return "#aa0";
						if(d.type==1) return "#a00";
						if(d.type==2) return "#00a";
					})
					.on("click", function(d){
						// console.log(d)
						// $location.search(d,d.id);
						if(d.origin===false) window.location.href="#/o/" + d.id ;
						else window.location.href="#/o/"+ d.origin + "?d=" + d.id ;
					})
					.on("mouseover", function(d) {
						// console.log('hello');
						div.style("background", function() {
							if(d.type===0) return "rgba(255,255,200,0.9)";
							if(d.type==1) return "rgba(255,200,200,0.9)";
							if(d.type==2) return "rgba(200,200,255,0.9)";
						});
						div.style("border-color", function() {
							// color(d.group); 
							if(d.type===0) return "#aa0";
							if(d.type==1) return "#a00";
							if(d.type==2) return "#00a";
						});
						div.transition()
							// .delay(750)
							.duration(500)
							.style("opacity", 1);
						div.html(d.caption+"<br>"+d.hweight+" replies")
							.style("left", (d3.event.pageX) + "px")
							.style("top", (d3.event.pageY - 28) + "px");
					})
					.on("mouseout", function(d) {
						div.transition()
							.duration(500)
							.style("opacity", 0);
					})
					.call(force.drag);
				// node.append("title")
				// 	// .text(function(d) { return d.name; });
				// 	.text(function(d) { return d.caption; });
					// .text(function(d) { return d.name; });
					// .text(function(d) { return d.caption; });

				//Bind the 'tick' event
				force.on("tick", function() {
				link.attr("x1", function(d) {
						// return d.source.x?d.source.x:0;
						return d.source.x;
					})
					.attr("y1", function(d) {
						// return d.source.y?d.source.y:0;
						return d.source.y;
					})
					.attr("x2", function(d) {
						// return d.target.x?d.source.x:0;
						return d.target.x;
					})
					.attr("y2", function(d) {
						// return d.target.y?d.source.y:0;
						return d.target.y;
					});

				node.attr("cx", function(d) {
						// return d.x?d.x:0;
						return d.x;
					})
					.attr("cy", function(d) {
						// return d.y?d.y:0;
						return d.y;
					});
				});

				//rescale();

				
			};
			$scope.$watch(function(){return IC.vertical.length;},function(){
				// console.log(IC.vertical,IC.links);
				if(IC.vertical.length>1) {
					$scope.visualizeData();
				}
			});
		}
	};
}]);
