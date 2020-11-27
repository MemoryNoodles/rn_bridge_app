/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 */

import React, { Component } from 'react';
import {
  SafeAreaView,
  StyleSheet,
  ScrollView,
  View,
  Text,
  StatusBar,
  TouchableOpacity,
  NativeModules,
  NativeEventEmitter,
} from 'react-native';
 
// var TDBridge = NativeModules.TDBridge
var TDBridge = NativeModules.jsClassName

const {jsClassName} = NativeModules;

const TDObserver = new NativeEventEmitter(jsClassName)

const observer = TDObserver.addListener("BridgeObserver", (obs)=>{
  // this.setState = ({
  //   waitString: obs,
  // })
  console.debug(obs)
})

export default class App extends Component {

  constructor(props) {
    super(props)
    this.state = {
      waitString: '',
      callbackString: '',
    }
  }

  componentDidMount() {
    this.setState({
      waitString:  "android sendAndWaitKey",
      callbackString:  "android sendAndCallbackKey",
    })
  }

  componentWillUnmount() {
    observer.remove();
  }

  render() {
    return (
      <SafeAreaView style={{ flex: 1, alignItems: 'stretch' }} >

        <TouchableOpacity style={{flex:1}} onPress={() => {TDBridge.send()}}>
          <Text> { "Android no data"} </Text>
        </TouchableOpacity>

        <TouchableOpacity style={{flex:1}} onPress={() => {TDBridge.sendAndCallback((cb)=> {
          console.debug("sendAndCallback    > ",cb);
          this.setState({callbackString: cb})
        })}}>
          <Text> {this.state.callbackString} </Text>
        </TouchableOpacity>

        <TouchableOpacity style={{flex:1}} onPress={() => {TDBridge.sendAndWait()}}>
          <Text> {this.state.waitString} </Text>
        </TouchableOpacity>

      </SafeAreaView>
    );
  }
};

const styles = StyleSheet.create({

});

