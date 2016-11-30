function distances = dist(x1,y1,class_train,l1,class_label)
% 	distances = [];
    distances = zeros(l1,2);
	for i = 1:l1
		x2 = class_train(i,1);
		y2 = class_train(i,2);
		d = eucdist(x1,y1,x2,y2);
		distances(i,1) = d;
        distances(i,2) = class_label;
	end
end

function d = eucdist(x1,y1,x2,y2)
	d = sqrt(((x2-x1)^2)+((y2-y1)^2));
end