# Black Board Predict

 The goal of this project was to predict if a student was going to pass a class within the first 3 weeks of the class in order
to inform teachers, so they could put more attention to specific students and in the end increase passing rates. The 
university I was at used a model by Blackboard based off of grade data, interaction data and student data, but wanted something
internal that they could understand and manipulate. My first goal was to replicate the model. I did this successfully using a 
Random Forest model from sklearn and it ended up with higher precision and recall in week three than the previous Blackboard model.
The most important features in the model were grade percentage, grade percentage rank in class, cumulative GPA, previous term GPA
and total durantion spent on Blackboard rank in class, all of which make sense. 

The Blackboard model performed better in the later weeks of the semester but worse early on which is where we wanted ours to be
good as it gave us more time to intervene with the teachers or students. A more detailed analysis can be seen in the slides.
The 3 Jupyter Notebooks are made for the baseline at week 0, all undergraduate classes at week 3 and the top 100 DFW classes at
week 3. The top 100 DFW classes are just the 100 most failed classes at the university. 
