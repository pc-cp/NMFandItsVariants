function percent = calculate_percent(A, B, label, testset, test_label, trainIdx, nClass)
     %% Using 1-NN to classify
     
     %ID(nClass-by-3)
     ID=locate(label);  
     Index=compare(A,B,trainIdx);
     ind=IDFromUnknowID(Index,ID,nClass);
     
     %x存取测试集通过算法得到的类别标签与测试集真正的标签进行匹配，x为列向量，维度为正确匹配的数量
     x=find((ind-test_label)==0);
     percent=length(x)/(size(testset,2));
     %得到准备率：正确匹配的数量/测试集总数量
     
end