//  main.cpp
//  water
//  Created by Preston Ong on 9/27/16.
//  Copyright © 2016 Preston Ong. All rights reserved.
//  This program calculates the approximate amount of water produced, according to the mass of hydrogen and oxygen.

#include <iostream>
using namespace std;

class hydrogen {
private:
    float massH; //input mass of hydrogen
    float moleH; //hydrogen mole
    float molarH=2.00;
    
public:
    hydrogen(float molarH=2.00) {massH=molarH;};
    void setMassH (float inMassH) {massH=inMassH;};
    float getMolH (){
        moleH=(massH/molarH);
        return moleH;
    } //hydrogen mole number getter
};

class oxygen {
private:
    float massO; //input mass of oxygen.
    float moleO; //mole number of oxygen.
    float molarO=32.00;
    
public:
    oxygen(float molarO=32.00) {massO=molarO;};
    void setMassO (float inMassO) {massO=inMassO;};
    float getMolO () {
        moleO = (massO/molarO);
        return moleO;
    } //mole number oxygen getter.
};

class water {
private:
    float molarMassW = 18.00;
    float massW;
    float moleW;
    hydrogen h;
    oxygen o;
    
public:
    //Setters for hydrogen and oxygen masses must be re-created in this class to allow non-static values to remain consistent.
    
    void inputMassH (float inFinalMassH) {h.setMassH(inFinalMassH);};
    void inputMassO (float inFinalMassO) {o.setMassO(inFinalMassO);};
    
    //Getting the moles from both classes.
    
    float getfinalH() {return h.getMolH();};
    float getfinalO() {return o.getMolO();};
    
    float getMolW() {
        //oxygen is the limiting agent.
        if ((getfinalH())/(getfinalO())>2) {
            moleW=(2*getfinalO());
        }
        //hydrogen is the limiting agent.
        else{
            moleW=getfinalH();
        }
        return moleW;
    };
    
    float getMassW() {
        massW = (getMolW()*molarMassW);
        return massW;
    }
};

int main() {
    float i;
    float j;
    //converting mass of hydrogen to moles.
    cout<<"Input mass of hydrogen in grams. " << endl;
    cin>>i;
    water w;
    w.inputMassH(i);
    cout<<"The mole number for hydrogen gas is "<<w.getfinalH()<< " moles" <<endl;
    cout<<endl;
    //converting mass of oxygen to moles.
    cout<<"Input mass of oxygen in grams. "<<endl;
    cin>>j;
    w.inputMassO(j);
    cout<<"The mole number for oxygen gas is "<<w.getfinalO()<< " moles" <<endl;
    cout<<endl;
    //the magic of COMPOSITION is going to produce the mass of WATER!
    cout<<"The amount of water vapor produced is "<<w.getMolW()<<" moles and "<< w.getMassW() << " grams."<<endl;
    return 0;
}
