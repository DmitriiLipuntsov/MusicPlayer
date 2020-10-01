//
//  TrackDetailViewController.swift
//  MusicPlayer
//
//  Created by Михаил Липунцов on 23.06.2020.
//  Copyright © 2020 Дмитрий липунцов. All rights reserved.
//

import UIKit

class TrackDetailViewController: UIViewController {
    
    private var trackDetailView = TrackDetailView()
    var presenter: TrackDetailPresenterProtocol?
    var tracks: [TrackModel.Track]?
    var player = Player.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loadAllView()
        creatButtonsActions()
        creatSlidersAction()
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    override func viewWillLayoutSubviews() {
        setImageForPlayButton()
        player.observePlayerCurrantTime(slider: trackDetailView.currentTimeSlider,
                                        currentTimeLabel: trackDetailView.currentTimeLabel,
                                        durationLabel: trackDetailView.durationLabel)
    }
    
    private func setImageForPlayButton() {
        if player.isPlaying {
            trackDetailView.trackControlView.playPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        } else {
            trackDetailView.trackControlView.playPauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        }
    }
    
    private func loadAllView() {
        view.addSubview(trackDetailView)
        trackDetailView.translatesAutoresizingMaskIntoConstraints = false
        trackDetailView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        trackDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        trackDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        trackDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        trackDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        
    }
    
    //MARK: - NotificationCenter selector(playerDidFinishPlaying)
    @objc func playerDidFinishPlaying() {
        nextTrackButtonPressed()
    }
        
    //MARK: - ButtonsActions
    
    private func creatButtonsActions() {
        trackDetailView.dragDownButton.addTarget(
            self,
            action: #selector(dragDownButtonPressed),
            for: .touchUpInside
        )
        
        trackDetailView.trackControlView.previousTrackButton.addTarget(
            self,
            action: #selector(previousTrackButtonPressed),
            for: .touchUpInside
        )
        
        trackDetailView.trackControlView.playPauseButton.addTarget(
            self,
            action: #selector(playPouseButtonPressed),
            for: .touchUpInside
        )
        
        trackDetailView.trackControlView.nextTrackButton.addTarget(
            self,
            action: #selector(nextTrackButtonPressed),
            for: .touchUpInside
        )
    }
    
    @objc func dragDownButtonPressed() {
        
        dismiss(animated: true, completion: nil)
        navigationController?.isNavigationBarHidden = false
        presenter?.popToRoot()
        
    }
    
    //MARK: - Track control buttons actions
    
    @objc func previousTrackButtonPressed() {
        presenter?.nextTrack(isNextTrack: false)
    }
    
    @objc func playPouseButtonPressed() {
        if player.avPlayer.timeControlStatus == .paused {
            player.avPlayer.play()
            player.isPlaying = true
            trackDetailView.trackControlView.playPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        } else {
            player.avPlayer.pause()
            player.isPlaying = false
            trackDetailView.trackControlView.playPauseButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        }
    }
    
    @objc func nextTrackButtonPressed() {
        presenter?.nextTrack(isNextTrack: true)
    }
    
    //MARK: - SlidersAction
    
    private func creatSlidersAction() {
        
        trackDetailView.volumeSlider.addTarget(
            self,
            action: #selector(handleVolumeSlider),
            for: .allEvents
        )
        
        trackDetailView.currentTimeSlider.addTarget(
            self,
            action: #selector(handelCurrentTimerSlider),
            for: .allEvents
        )
    }
    
    @objc func handleVolumeSlider() {
        player.avPlayer.volume = trackDetailView.volumeSlider.value
    }
    
    @objc func handelCurrentTimerSlider() {
        player.handelCurrentTimerSlider(slider: trackDetailView.currentTimeSlider)
    }
    
}

extension TrackDetailViewController: TrackDetailViewProtocol {
    
    func setTrack(track: TrackModel.Track?) {
        trackDetailView.artistNameLabel.text = track?.artistName
        trackDetailView.trackNameLabel.text = track?.trackName
        let string600 = track?.iconUrlString?.replacingOccurrences(of: "100x100", with: "600x600")
        guard let url = URL(string: string600 ?? "") else { return }
        trackDetailView.trackImageView.sd_setImage(with: url)
        guard let previewUrl = track?.previewUrl else { return }
        player.playTrack(previewUrl: previewUrl)
        player.observePlayerCurrantTime(slider: trackDetailView.currentTimeSlider,
                                        currentTimeLabel: trackDetailView.currentTimeLabel,
                                        durationLabel: trackDetailView.durationLabel)
        trackDetailView.trackControlView.playPauseButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
    }
}
